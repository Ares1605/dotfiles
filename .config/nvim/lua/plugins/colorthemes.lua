return {
  {
    'Verf/deepwhite.nvim',
    lazy = false,
    priority = 1000
  },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000
  },
  {
    "jacoborus/tender.vim",
    lazy = false,
    priority = 1000
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000
  },
  {
    "mipmip/vim-petra",
    lazy = false,
    priority = 1000
  },
  {
    "Abstract-IDE/Abstract-cs",
    lazy = false,
    priority = 1000
  },
  {
    "vim-scripts/true-monochrome",
    lazy = false,
    priority = 1000
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000
  },
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000
  },
  {
    "zenbones-theme/zenbones.nvim",
    priority=1000,
    lazy=false
  },
  {
    "rockerBOO/boo-colorscheme-nvim",
    priority=1000,
    lazy=false
  },
  {
    "ashen-org/ashen.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
  },
  -- {
  --   "wtfox/jellybeans.nvim",
  --   priority = 1000,
  --   lazy=false,
  --   config = function()
  --     require("jellybeans").setup()
  --     vim.cmd.colorscheme("jellybeans")
  --   end,
  -- },
  {
    "ramojus/mellifluous.nvim",
    priority=1000,
    lazy=false
  },
  {
    "ilof2/posterpole.nvim",
    priority=1000,
    lazy=false
  },
  {
    "sample-usr/rakis.nvim",
    priority=1000,
    lazy=false
  },
  {
    'Donearm/Ubaryd',
    priority=1000,
    lazy = false
  },
  {
    'coffee-theme/coffee.vim',
    priority = 1000,
    lazy=false
  },
  {
    "doums/espresso.nvim",
    priority = 1000,
    lazy = false
  },
  {
    "xero/miasma.nvim",
    priority = 1000,
    lazy = false
  },
  {
    "qaptoR-nvim/chocolatier.nvim",
    priority = 1000,
    lazy = false
  },
  {
    "gustavoprietop/doom-themes.nvim",
    priority = 1000,
    lazy = false,
  },
  {
    "AlessandroYorba/Alduin",
    priority = 1000,
    lazy = false
  },
  {
    "neanias/everforest-nvim",
    priority = 1000,
    lazy = false
  },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 1000,
    lazy = false
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
    lazy = false
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  -- Bamboo theme
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
  },
  -- Lush (required for Ares)
  {
    "rktjmp/lush.nvim",
    lazy = false,
    priority = 1001,  -- Load before Ares
  },
  -- Ares theme
  {
    'ab-dx/ares.nvim',
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
  },
  -- Gruvbox Baby theme
  {
    'luisiacc/gruvbox-baby',
    branch = 'main',
    lazy = false,
    priority = 1000,
  },
  -- Gruvbox Material theme
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
  }
}
