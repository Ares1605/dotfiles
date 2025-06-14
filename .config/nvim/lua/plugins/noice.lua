-- plugins/noice.lua
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = { buf_options = { filetype = "vim" } },
        icons = {
          ["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
          ["?"] = { icon = " ", hl_group = "DiagnosticWarn" },
          [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
        },
      },
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = false,
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
      -- Disable the conflicting LSP features
      lsp = {
        hover = {
          enabled = false,  -- Disable hover to avoid conflicts
        },
        signature = {
          enabled = false,  -- Disable signature help to avoid conflicts
        },
        -- You can still keep other LSP features enabled if you want
        message = {
          enabled = true,
        },
        progress = {
          enabled = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  }
}
