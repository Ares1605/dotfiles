return {
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        opts = {
            backends = { "lsp" },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            {"<leader>a", "<cmd>AerialToggle<cr>", { desc = "Toggle Aerial code outlining" } }
        }
    }
}
