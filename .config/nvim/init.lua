vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.clipboard="unnamedplus"

vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.wrap = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<cmd>w<cr><ESC>", { desc = "Save file" })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle text wrapping" })

vim.keymap.set("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Go to previous buffer" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
    callback = function()
	vim.hl.on_yank()
    end,
})

require("config.lazy")

vim.lsp.enable("lua_ls")
