-- ~/.config/nvim/lua/user/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add regex to ensure_installed list
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "regex")
      table.insert(opts.ensure_installed, "tsx")
    end

    opts.highlight = opts.highlight or {}
    opts.highlight.disable = opts.highlight.disable or {}
    vim.list_extend(opts.highlight.disable, { "typescript", "tsx" })

    opts.indent = opts.indent or {}
    opts.indent.disable = opts.indent.disable or {}
    vim.list_extend(opts.indent.disable, { "typescript", "tsx" })

    return opts
  end,

  init = function()
    if not vim.g.ares_treesitter_compat_patched then
      local ts = vim.treesitter

      local function normalize_node(node)
        if type(node) ~= "table" then
          return node
        end

        for _, item in ipairs(node) do
          if item ~= nil then
            return item
          end
        end
      end

      local get_range = ts.get_range
      ts.get_range = function(node, source, metadata)
        node = normalize_node(node)
        if not node then
          return { 0, 0, 0, 0 }
        end
        return get_range(node, source, metadata)
      end

      local get_node_text = ts.get_node_text
      ts.get_node_text = function(node, source, opts)
        node = normalize_node(node)
        if not node then
          return ""
        end
        return get_node_text(node, source, opts)
      end

      vim.g.ares_treesitter_compat_patched = true
    end

    local group = vim.api.nvim_create_augroup("ares_disable_ts_treesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = { "typescript", "typescriptreact" },
      callback = function(args)
        vim.treesitter.stop(args.buf)
      end,
    })
  end,
}
