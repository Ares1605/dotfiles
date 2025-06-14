-- lua/plugins/ui.lua
return {
  ---------------------------------------------------------------------------
  -- 1 · Sync kitty (load FIRST, then poke once)
  -- This plugin helps sync Neovim's background with the terminal's.
  -- Ensure your terminal emulator (e.g., Kitty) is also configured for true transparency.
  ---------------------------------------------------------------------------
  {
    "typicode/bg.nvim",
    lazy = false,        -- load during startup
    priority = 1000,     -- load before anything UI-related
  },

  ---------------------------------------------------------------------------
  -- 2 · Strip Neovim’s own backgrounds
  -- This plugin sets highlight group backgrounds to NONE, making Neovim's UI transparent.
  ---------------------------------------------------------------------------
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 900,
    opts = {
      -- These are highlight groups that transparent.nvim should explicitly make transparent.
      -- 'Normal' is usually handled by default, but it's good to ensure others are.
      extra_groups = {
        -- "NormalFloat",     -- Floating windows (e.g., LSP hover, diagnostics)
        -- "NormalNC",        -- Non-current window normal background
        -- "SignColumn",      -- Git signs, diagnostic signs column
        -- "TelescopeNormal", -- Telescope popup background
        -- "Pmenu",           -- Popup menu background (e.g., auto-completion)
        -- "PmenuSel",        -- Popup menu selected item background
        -- "PmenuSbar",       -- Popup menu scrollbar
        -- "PmenuThumb",      -- Popup menu scrollbar thumb
        -- "MsgArea",         -- Message area at the bottom
        -- "CmdLine",         -- Command line input area
        -- "FloatBorder",     -- Border of floating windows

        -- Add any other highlight groups here if you notice they still have a background.
        -- For example: "NeoTreeNormal" if you use Neo-tree and want it transparent.
      },
      -- 'groups' can be used to explicitly define groups to clear.
      -- Leaving it empty means transparent.nvim uses its default list which includes 'Normal'.
      groups = {},
    },
    -- The 'config' function is called when the plugin loads.
    -- transparent.nvim automatically sets up an autocmd to apply transparency
    -- whenever a new ColorScheme is loaded, which is ideal here.
    config = function(_, opts)
      require("transparent").setup(opts)
    end,
  },

  ---------------------------------------------------------------------------
  -- 3 · Themery for colorscheme management and automatic application on startup
  ---------------------------------------------------------------------------
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 800,
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "ayu",
            colorscheme = "ayu",
          },
          {
            name = "tender",
            colorscheme = "tender"
          },
          {
            name = "abstract",
            colorscheme = "abscs",
          },
          {
            name = "monochrome",
            colorscheme = "true-monochrome",
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
            name = "deep white",
            colorscheme = "deepwhite"
          },
          {
            name = "petra",
            colorscheme = "petra"
          },
          {
            name = "rose pine",
            colorscheme = "rose-pine"
          },
          {
            name = "rose pine moon",
            colorscheme = "rose-pine-moon"
          },
          {
            name = "sunset cloud",
            colorscheme = "sunset_cloud",
          },
          {
            name = "radioactive waste",
            colorscheme = "radioactive_waste"
          },
          {
            name = "forest_stream",
            colorscheme = "forest_stream"
          },
          {
            name = "crimson moonlight",
            colorscheme = "crimson_moonlight"
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
            name = "zenbones",
            colorscheme = "zenbones",
            before = [[
            vim.opt.background = "light"
            ]]
          },
        }
      })
    end
  },
}
