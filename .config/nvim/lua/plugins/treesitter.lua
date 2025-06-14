-- ~/.config/nvim/lua/user/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add regex to ensure_installed list
    if opts.ensure_installed ~= "all" then
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "regex")
    end
    return opts
  end,
}
