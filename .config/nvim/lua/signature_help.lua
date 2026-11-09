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

local lsp_hover_buf = vim.api.nvim_create_buf(false, true)
local lsp_hover_win = vim.api.nvim_open_win(lsp_hover_buf, false, {
    relative = "editor",
    anchor = "NE",
    row = 1,
    col = vim.o.columns - 1,
    width = math.max(1, math.min(100, vim.o.columns - 4)),
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

        get_signature(function(signature)
            if current ~= generation then
                return
            end

            if not signature then
                vim.api.nvim_win_set_config(lsp_hover_win, { hide = true })
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
                vim.list_extend(lines, vim.split(documentation, "\n"))
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
                col = vim.o.columns - 1,
                width = math.max(1, math.min(100, vim.o.columns - 4)),
                hide = false,
            })

            local height = vim.api.nvim_win_text_height(lsp_hover_win, {}).all

            vim.api.nvim_win_set_config(lsp_hover_win, {
                height = math.max(1, math.min(height, 20, vim.o.lines - 5)),
            })
        end)
    end,
})
