-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Disable relative line numbers on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("set nornu")
  end,
})
-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Create an autocommand group
local scroll_group = vim.api.nvim_create_augroup("SwitchScrolloffTopBottom", { clear = true })

-- Create the autocommand
vim.api.nvim_create_autocmd("CursorMoved", {
  group = scroll_group,
  callback = function()
    local win_height = vim.api.nvim_win_get_height(0)
    local cursor_line = vim.fn.winline()
    local buffer_line = vim.fn.line('.')
    local last_line = vim.fn.line('$')
    
    if cursor_line <= 5 or (last_line - buffer_line + 1) <= 5 then
      vim.opt_local.scrolloff = 0
    else
      vim.opt_local.scrolloff = 5
    end
  end,
})

require "lazy_setup"
require "polish"

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end
map('n', '<C-j>', function()
    vim.cmd('normal! j')
    vim.cmd('normal! <C-e>')
    vim.cmd('normal! zz')
end, { desc = "Move cursor down, scroll down, and center screen" })

map('n', '<C-k>', function()
    vim.cmd('normal! k')
    vim.cmd('normal! <C-y>')
    vim.cmd('normal! zz')
end, { desc = "Move cursor down, scroll down, and center screen" })

-- In your init.lua or options.lua
-- -- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"


require("notify").setup({
  background_colour = "#000000",
})

vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-n>:q<CR>', {noremap = true, silent = true})

-- vim.cmd "colorscheme lushwal"
-- require("lushwal").add_reload_hook {
--   vim.cmd "LushwalCompile",
-- }
