vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.clipboard="unnamedplus"
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.wrap = false

-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal
-- blocks of text.
vim.opt.breakindent = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
vim.o.mouse = 'a' -- Enable mouse support for all modes
vim.o.showmode = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.title = true

vim.o.titlestring = "nvim " .. vim.fs.basename(vim.fn.getcwd())

-- IDK What sign column is..
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true


-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

vim.keymap.set("n", "<Down>", function()
  vim.cmd('normal! j')
  vim.cmd('normal! zz')
end)
vim.keymap.set("n", "<Up>", function()
  vim.cmd('normal! k')
  vim.cmd('normal! zz')
end)

vim.keymap.set("n", "<PageDown>", "15j", { desc = "Page down" })
vim.keymap.set("n", "<PageUp>", "15k", { desc = "Page up" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<cmd>w<cr><ESC>", { desc = "Save file" })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle text wrapping" })

vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Go to previous buffer" })

vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count=1 })
end, { desc = "Go to next error" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count=-1 })
end, { desc = "Go to previous error" })
vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "View diagnostic message" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<S-k>", function()
  vim.lsp.buf.hover({
    border = "rounded",
  })
end)

vim.diagnostic.config({
float = {
    border = "rounded", -- Options: "none", "single", "double", "rounded", "solid", "shadow"
    header = "",        -- Removes the "Diagnostics:" header for a cleaner look
  },
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

require("config.lazy")

require("snacks").words.enable()

vim.cmd("colorscheme slate")

vim.lsp.enable("lua_ls")
vim.lsp.enable("intelephense")
vim.lsp.enable("vtsls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("terraformls")

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
