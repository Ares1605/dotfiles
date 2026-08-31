return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        signs_staged_enable = false,
        signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        blame_formatter = nil, -- Use default
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
    },
    keys = {
        { "<leader>B", function()
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)

                if vim.bo[buf].filetype == "gitsigns-blame" then
                    vim.api.nvim_win_close(win, false)
                    return
                end
            end

            local gitsigns = require("gitsigns")
            local prefocused_win = vim.api.nvim_get_current_win()
            gitsigns.blame(nil, function(err)
                if err ~= nil then
                    vim.notify("Failed to attach Git blame buffer: " .. err, vim.log.levels.WARN)
                    return
                end


                local blame_win = vim.api.nvim_get_current_win()
                -- If the current window did not change, gitsigns failed to create and focus the blame buffer
                if blame_win == prefocused_win then
                    vim.notify("Blame buffer could not be created", vim.log.levels.WARN)
                    return
                end
                local blame_width = vim.api.nvim_win_get_width(blame_win)

                vim.cmd("wincmd L")
                vim.api.nvim_win_set_width(blame_win, blame_width)

                vim.api.nvim_set_current_win(prefocused_win)
            end)
        end, desc = "Toggle Git blame pane" }
    }
}
