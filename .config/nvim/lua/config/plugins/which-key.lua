return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        lazy = true,
        opts = {
            delay = function(ctx)
                return 400
            end,
        }
    }
}
