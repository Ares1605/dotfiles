return {
    {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
	    "nvim-lua/plenary.nvim",
	    -- optional but recommended
	    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
	    {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files"},
	    {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep"},
	    {"<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers"}
	}
    }
}
