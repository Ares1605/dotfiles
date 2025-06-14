-- lua/plugins/notify.lua  (or anywhere in your Lazy/Astro spec list)
return {
  "rcarriga/nvim-notify",
  -- grab the patched code; remove this line once a new tag is cut
  commit = "b5825cf",
  -- or: version = "*"
  config = function()
    require("notify").setup({
      background_colour = "#000000",  -- keep kitty/bg.nvim happy
    })
  end,
}
