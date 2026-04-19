vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.clipboard="unnamedplus"

vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.wrap = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-S-j>", function()
    vim.cmd('normal! j')
    vim.cmd('normal! zz')
end)
vim.keymap.set("n", "<C-S-k>", function()
    vim.cmd('normal! k')
    vim.cmd('normal! zz')
end)

vim.keymap.set("n", "<C-d>", "15j", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "15k", { desc = "Page up" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<cmd>w<cr><ESC>", { desc = "Save file" })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle text wrapping" })

vim.keymap.set("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
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

vim.keymap.set("n", "<leader>a", "<cmd>AerialNavToggle<cr>", { desc = "Toggle Aerial code outlining" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
    callback = function()
	vim.hl.on_yank()
    end,
})

require("config.lazy")

vim.lsp.enable("lua_ls")
vim.lsp.enable("intelephense")
vim.lsp.enable("vtsls")
