return {
  "karb94/neoscroll.nvim",
  commit = "532dcc8cea4287c4cad6bb77532989a8217cfc7b",
  event = "VeryLazy",
  config = function()
    local neoscroll = require('neoscroll')
    neoscroll.setup({
      -- All other easing functions will use the default
      easing = "sine",
    })

    local t = {}
    -- Syntax: t[keys] = {function, {function arguments}}
    t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '30'}}
    t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '30'}}

    require('neoscroll.config').set_mappings(t)
  end
}
