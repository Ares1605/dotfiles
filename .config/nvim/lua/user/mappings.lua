return {
  n = {
    ["n"] = {
      function()
        print(vim.fn.expand('%'))
      end,
      desc = "Print current file path"
    },
    -- ["grr"] = {
    --   function()
    --     local function lsp_reference_float()
    --       vim.lsp.handlers["textDocument/references"] = function(_, result, ctx)
    --         if not result or vim.tbl_isempty(result) then
    --           vim.notify("No references found")
    --           return
    --         end
    --
    --         local bufnr = vim.api.nvim_create_buf(false, true)
    --         local contents = {}
    --
    --         for i, ref in ipairs(result) do
    --           local fname = vim.uri_to_fname(ref.uri)
    --           local line = ref.range.start.line + 1
    --           local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ""
    --           table.insert(contents, string.format("%d. %s:%d\n   %s", i, fname, line, text))
    --         end
    --
    --         vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
    --         vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
    --         vim.api.nvim_buf_set_option(bufnr, 'filetype', 'lsp-references')
    --
    --         local width = math.min(#contents[#contents], 80)
    --         local height = math.min(#contents, 10)
    --
    --         local opts = {
    --           relative = 'cursor',
    --           width = width,
    --           height = height,
    --           col = 0,
    --           row = 1,
    --           style = 'minimal',
    --           border = 'rounded'
    --         }
    --
    --         vim.api.nvim_open_win(bufnr, true, opts)
    --       end
    --     end
    --
    --     lsp_reference_float()
    --     vim.lsp.buf.references()
    --   end,
    --   desc = "Go to references (floating window)"
    -- },
  },
}

