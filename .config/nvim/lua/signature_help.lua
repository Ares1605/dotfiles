local function get_signature(callback)
  local method = "textDocument/signatureHelp"
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({
    bufnr = bufnr,
    method = method,
  })[1]

  if not client then
    callback(nil)
    return
  end

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

  client:request(method, params, function(err, result)
    if err or not result or not result.signatures then
      callback(nil)
      return
    end

    local signature = result.signatures[(result.activeSignature or 0) + 1]
      or result.signatures[1]

    callback(signature)
  end, bufnr)
end

local function limit_hover_documentation(lines)
  local declaration_end = 0
  if lines[1] and lines[1]:match("^```") then
    for i = 2, #lines do
      if lines[i]:match("^```%s*$") then
        declaration_end = i
        break
      end
    end
  end

  local first = declaration_end + 1
  while first <= #lines and lines[first]:match("^%s*$") do
    first = first + 1
  end

  local limited = {}
  for i = 1, declaration_end do
    limited[#limited + 1] = lines[i]
  end
  if declaration_end > 0 and first <= #lines then
    limited[#limited + 1] = ""
  end

  local in_code = false
  for i = first, math.min(first + 4, #lines) do
    limited[#limited + 1] = lines[i]
    if lines[i]:match("^```") then
      in_code = not in_code
    end
  end
  if in_code then
    limited[#limited + 1] = "```"
  end
  return limited
end

local function get_hover(callback)
  local method = "textDocument/hover"
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = bufnr, method = method })[1]
  if not client then
    callback(nil)
    return
  end

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request(method, params, function(err, result)
    if err or not result or not result.contents then
      callback(nil)
      return
    end
    local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    callback(#lines > 0 and limit_hover_documentation(lines) or nil)
  end, bufnr)
end

local function expand_definition_range(client, bufnr, uri, location, callback)
  local range = location.targetRange or location.range
  local position = (location.targetSelectionRange or range).start
  local method = "textDocument/documentSymbol"

  if not client:supports_method(method) then
    callback(range)
    return
  end

  client:request(method, { textDocument = { uri = uri } }, function(err, symbols)
    if err or not symbols then
      callback(range)
      return
    end

    local function contains(candidate)
      local first, last = candidate.start, candidate["end"]
      return (position.line > first.line
          or (position.line == first.line and position.character >= first.character))
        and (position.line < last.line
          or (position.line == last.line and position.character < last.character))
    end

    -- DocumentSymbol ranges cover the declaration, not just its identifier.
    local function visit(items)
      for _, symbol in ipairs(items) do
        local candidate = symbol.range or (symbol.location and symbol.location.range)
        if candidate and contains(candidate) and (not symbol.location or symbol.location.uri == uri) then
          -- Only expand the symbol being defined, not its enclosing function.
          if contains(symbol.selectionRange or candidate) then
            range = candidate
          end
          if symbol.children then
            visit(symbol.children)
          end
          return
        end
      end
    end

    visit(symbols)
    callback(range)
  end, bufnr)
end

local function get_literal_type_position(bufnr)
  if vim.bo[bufnr].filetype ~= "go" then
    return
  end

  -- Resolve the enclosing type throughout the literal, including unfinished values.
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok then
    return
  end
  parser:parse()
  local node = vim.treesitter.get_node({ bufnr = bufnr })
  while node do
    if node:type() == "composite_literal" then
      local type_node = node:field("type")[1]
      if not type_node then
        return
      end
      if type_node:type() == "generic_type" then
        type_node = type_node:field("type")[1]
      end
      if type_node:type() == "qualified_type" then
        type_node = type_node:field("name")[1]
      end
      local row, col = type_node:start()
      return { row = row, col = col }
    end
    node = node:parent()
  end
end

local function get_definition(callback, position)
  local method = "textDocument/definition"
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({
    bufnr = bufnr,
    method = method,
  })[1]

  if not client then
    callback(nil)
    return
  end

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  if position then
    local line = vim.api.nvim_buf_get_lines(bufnr, position.row, position.row + 1, false)[1]
    params.position = {
      line = position.row,
      character = vim.str_utfindex(line, client.offset_encoding, position.col, false),
    }
  end
  client:request(method, params, function(err, result)
    if err or not result then
      callback(nil)
      return
    end

    -- Definition responses can be a Location, Location[], or LocationLink[].
    local location = result.uri and result or result[1]
    if not location then
      callback(nil)
      return
    end

    local uri = location.targetUri or location.uri
    local target = vim.uri_to_bufnr(uri)
    vim.fn.bufload(target)
    local filetype = vim.bo[target].filetype
    if filetype == "" then
      filetype = vim.filetype.match({ buf = target }) or ""
    end

    expand_definition_range(client, bufnr, uri, location, function(range)
      local first = range.start.line
      local last = range["end"].line + (range["end"].character > 0 and 1 or 0)
      last = math.min(math.max(first + 1, last), first + 20)

      local lines = { "```" .. filetype }
      vim.list_extend(lines, vim.api.nvim_buf_get_lines(target, first, last, false))
      lines[#lines + 1] = "```"
      callback(lines)
    end)
  end, bufnr)
end

local lsp_hover_buf = vim.api.nvim_create_buf(false, true)
local lsp_hover_win = vim.api.nvim_open_win(lsp_hover_buf, false, {
    relative = "editor",
    anchor = "NE",
    row = 1,
    col = vim.o.columns,
    width = math.max(1, math.min(70, vim.o.columns - 4)),
    height = 1,
    style = "minimal",
    focusable = false,
    hide = true,
})

vim.wo[lsp_hover_win].signcolumn = "no"
vim.wo[lsp_hover_win].wrap = true
vim.wo[lsp_hover_win].conceallevel = 2
vim.bo[lsp_hover_buf].syntax = "markdown"

-- Markdown highlighting, including fenced code when parsers are available.
pcall(vim.treesitter.start, lsp_hover_buf, "markdown")

local generation = 0

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    desc = "LSP signature and documentation",
    callback = function()
        local filetype = vim.bo.filetype
        generation = generation + 1
        local current = generation

        local function show_lines(lines)
            if current ~= generation then
                return
            end

            if not lines then
                vim.api.nvim_win_set_config(lsp_hover_win, { hide = true })
                return
            end

            while #lines > 1 and lines[#lines]:match("^%s*$") do
                table.remove(lines)
            end

            vim.api.nvim_buf_set_lines(lsp_hover_buf, 0, -1, false, lines)

            -- Set the width before measuring wrapped text.
            vim.api.nvim_win_set_config(lsp_hover_win, {
                relative = "editor",
                anchor = "NE",
                row = 1,
                col = vim.o.columns,
                width = math.max(1, math.min(70, vim.o.columns - 4)),
                hide = false,
            })

            local height = vim.api.nvim_win_text_height(lsp_hover_win, {}).all
            local max_height = math.min(vim.o.lines - 5, 11)

            vim.api.nvim_win_set_config(lsp_hover_win, {
                height = math.max(1, math.min(height, max_height)),
            })
        end

        local literal_type_position = get_literal_type_position(vim.api.nvim_get_current_buf())
        if literal_type_position then
            get_definition(function(lines)
                show_lines(lines)
            end, literal_type_position)
            return
        end

        get_signature(function(signature)
            if current ~= generation then
                return
            end

            if not signature then
                get_hover(function(lines)
                    if current ~= generation then
                        return
                    end
                    if lines then
                        show_lines(lines)
                        return
                    end
                    get_definition(function(definition_lines)
                        show_lines(definition_lines)
                    end)
                end)
                return
            end

            local lines = { "```" .. filetype }
            vim.list_extend(lines, vim.split(signature.label, "\n"))
            lines[#lines + 1] = "```"

            local documentation = signature.documentation
            if type(documentation) == "table" then
                documentation = documentation.value
            end

            if documentation and documentation ~= "" then
                lines[#lines + 1] = ""
                local documentation_lines = vim.split(documentation, "\n")
                for i = 1, math.min(5, #documentation_lines) do
                    lines[#lines + 1] = documentation_lines[i]
                end
            end

            show_lines(lines)
        end)
    end,
})
