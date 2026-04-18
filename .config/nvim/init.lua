vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.clipboard="unnamedplus"

vim.opt.number = true
vim.opt.shiftwidth = 4

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
    callback = function()
	vim.hl.on_yank()
    end,
})

require("config.lazy")
