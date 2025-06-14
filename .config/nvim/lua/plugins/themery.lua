return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        {
          name="ayu",
          colorscheme="ayu"
        },
        {
          name="tender",
          colorscheme="tender"
        },
        {
          name="abstract",
          colorscheme="abscs",
        },
        {
          name="monochrome",
          colorscheme="true-monochrome",
          before = [[
            vim.opt.background = "dark"
            vim.api.nvim_create_autocmd("ColorScheme", {
              pattern = "true-monochrome",
              callback = function()
                vim.api.nvim_set_hl(0, "CursorLine", { bg = "#303030", ctermbg = 236 })
              end
            })
          ]]
        },
        {
          name="deep white",
          colorscheme="deepwhite"
        },
        {
          name="petra",
          colorscheme="petra"
        },
        {
          name="rose pine",
          colorscheme="rose-pine"
        },
        {
          name="rose pine moon",
          colorscheme="rose-pine-moon"
        },
        {
          name="sunset cloud",
          colorscheme="sunset_cloud",
        },
        {
          name="radioactive waste",
          colorscheme="radioactive_waste"
        },
        {
          name="forest_stream",
          colorscheme="forest_stream"
        },
        {
          name="crimson moonlight",
          colorscheme="crimson_moonlight"
        },
        {
          name = "melange",
          colorscheme = "melange",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "mocha blue",
          colorscheme = "catppuccin-mocha",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "ashen",
          colorscheme = "ashen",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "citrus",
          colorscheme = "citruszest",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        -- {
        --   name = "jellybeans",
        --   colorscheme = "jellybeans",
        --   before = [[
        --     vim.opt.background = "dark"
        --   ]]
        -- },
        {
          name = "mellifluous.nvim",
          colorscheme = "mellifluous",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "posterpole",
          colorscheme = "posterpole",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "posterterm",
          colorscheme = "posterpole-term",
          before = [[
            vim.opt.background = "dark"
            require("notify").setup({
              background_colour = "#000000",
            })
          ]]
        },
        {
          name = "rakis",
          colorscheme = "rakis",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "ubaryd",
          colorscheme = "ubaryd"
        },
        {
          name = "kanagawa wave",
          colorscheme = "kanagawa-wave"
        },
        {
          name = "kanagawa dragon",
          colorscheme = "kanagawa-dragon"
        },
        {
          name = "bamboo",
          colorscheme = "bamboo"
        },
        {
          name = "ares",
          colorscheme = "ares"
        },
        {
          name = "gruvbox baby",
          colorscheme = "gruvbox-baby"
        },
        {
          name = "gruvbox material",
          colorscheme = "gruvbox-material",
          before = [[
            vim.g.gruvbox_material_enable_italic = true
          ]]
        },
        {
          name = "alduin",
          colorscheme = "alduin"
        },
        {
          name = "oxocarbon",
          colorscheme = "oxocarbon",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "no clown fiesta",
          colorscheme = "no-clown-fiesta"
        },
        {
          name = "everforest",
          colorscheme = "everforest",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "doom miramare",
          colorscheme = "doom-miramare",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "miasma",
          colorscheme = "miasma",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "chocolatier",
          colorscheme = "chocolatier",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "coffee",
          colorscheme = "coffee",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "espresso",
          colorscheme = "espresso",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "doom palenight",
          colorscheme = "doom-palenight",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "doom monokai flatland",
          colorscheme = "doom-monokai-flatland",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "doom fairy floss",
          colorscheme = "doom-fairy-floss",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "doom horizon",
          colorscheme = "doom-horizon",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "doom challenger deep",
          colorscheme = "doom-challenger-deep",
          before = [[
            vim.opt.background = "dark"
          ]]
        },
        {
          name = "kanagawa paper",
          colorscheme = "kanagawa-paper",
        },
        {
          name = "kanagawa paper ink",
          colorscheme = "kanagawa-paper-ink",
        },
        {
          name = "kanagawa paper canvas",
          colorscheme = "kanagawa-paper-canvas",
        },
        {
          name = "kanagawa lotus",
          colorscheme = "kanagawa-lotus"
        },
        {
          name = "rakis light",
          colorscheme = "rakis",
          before = [[
            vim.opt.background = "light"
          ]]
        },
        {
          name="zenbones",
          colorscheme="zenbones",
          before = [[
            vim.opt.background = "light"
          ]]
        },
      }
    })
  end
}
