-- Define our custom mappings
local custom_mappings = {
  n = {
    -- ["grr"] = {
    --   function()
    --     local function lsp_reference_float()
    --       vim.lsp.handlers["textDocument/references"] = function(_, result, ctx)
    --         if not result or vim.tbl_isempty(result) then
    --           vim.notify("No references found")
    --           return
    --         end
    --         local bufnr = vim.api.nvim_create_buf(false, true)
    --         local contents = {}
    --         local references = {}
    --         for i, ref in ipairs(result) do
    --           local fname = vim.uri_to_fname(ref.uri)
    --           local line = ref.range.start.line + 1
    --           local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ""
    --           table.insert(contents, string.format("%s:%d", fname, line))
    --           table.insert(contents, "   " .. text)
    --           table.insert(references, {uri = ref.uri, range = ref.range})
    --         end
    --         vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
    --         vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
    --         vim.api.nvim_buf_set_option(bufnr, 'filetype', 'lsp-references')
    --         -- Set up keymaps for the floating window
    --         local function jump_to_reference()
    --           local cursor = vim.api.nvim_win_get_cursor(0)
    --           local index = math.floor(cursor[1] / 3) + 1
    --           if references[index] then
    --             vim.api.nvim_win_close(0, true)
    --             vim.lsp.util.jump_to_location(references[index], "utf-8")
    --           end
    --         end
    --         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', '', {
    --           callback = jump_to_reference,
    --           noremap = true,
    --           silent = true,
    --         })
    --         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '', {
    --           callback = function() vim.api.nvim_win_close(0, true) end,
    --           noremap = true,
    --           silent = true,
    --         })
    --         local width = 80
    --         local height = math.min(#contents, 10)
    --         local opts = {
    --           relative = 'cursor',
    --           width = width,
    --           height = height,
    --           col = 0,
    --           row = 1,
    --           style = 'minimal',
    --           border = 'rounded'
    --         }
    --         local win = vim.api.nvim_open_win(bufnr, true, opts)
    --         vim.api.nvim_win_set_option(win, 'cursorline', true)
    --       end
    --     end
    --     lsp_reference_float()
    --     vim.lsp.buf.references()
    --   end,
    --   desc = "Go to references (interactive floating window)"
    -- },
["ga"] = {
      function()
        
        local function lsp_definition_float()
          
          vim.lsp.handlers["textDocument/definition"] = function(_, result, ctx)
            
            if not result or vim.tbl_isempty(result) then
              vim.notify("No definition found")
              return
            end
            if #result == 1 then
              vim.lsp.util.jump_to_location(result[1], "utf-8")
              return
            end
            local bufnr = vim.api.nvim_create_buf(false, true)
            local contents = {}
            local definitions = {}
            for i, def in ipairs(result) do
              local fname = vim.uri_to_fname(def.uri)
              local line = def.range.start.line + 1
              local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ""
              table.insert(contents, string.format("%s:%d", fname, line))
              table.insert(contents, "   " .. text)
              table.insert(definitions, {uri = def.uri, range = def.range})
            end
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
            vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
            vim.api.nvim_buf_set_option(bufnr, 'filetype', 'lsp-definitions')
            -- Set up keymaps for the floating window
            local function jump_to_definition()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local index = math.floor(cursor[1] / 3) + 1
              if definitions[index] then
                vim.api.nvim_win_close(0, true)
                vim.lsp.util.jump_to_location(definitions[index], "utf-8")
              end
            end
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', '', {
              callback = jump_to_definition,
              noremap = true,
              silent = true,
            })
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '', {
              callback = function() vim.api.nvim_win_close(0, true) end,
              noremap = true,
              silent = true,
            })
            local width = 80
            local height = math.min(#contents, 10)
            local opts = {
              relative = 'cursor',
              width = width,
              height = height,
              col = 0,
              row = 1,
              style = 'minimal',
              border = 'rounded'
            }
            local win = vim.api.nvim_open_win(bufnr, true, opts)
            vim.api.nvim_win_set_option(win, 'cursorline', true)
          end
        end
        lsp_definition_float()
        vim.lsp.buf.definition()
      end,
      desc = "Go to definition (interactive floating window if multiple)"
    },
  },
}

-- Now, let's set up Lazy with our existing configuration and new mappings
require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  { import = "community" },
  { import = "plugins" },
  -- Add a new spec for our custom mappings
  {
    "AstroNvim/AstroNvim",
    opts = function(_, opts)
      -- Extend the existing mappings with our custom ones
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, custom_mappings)
      return opts
    end,
  },
} --[[@as LazySpec]], {
  install = { colorscheme = { "astrotheme", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])

-- Apply the custom mappings
for mode, mode_mappings in pairs(custom_mappings) do
  for lhs, mapping in pairs(mode_mappings) do
    vim.keymap.set(mode, lhs, mapping[1], { desc = mapping.desc })
  end
end
