return {
    {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = false,
	dependencies = {
	    "nvim-lua/plenary.nvim",
	    "MunifTanjim/nui.nvim",
	    "nvim-tree/nvim-web-devicons"
	},
	opts = {
	    filesystem = {
		hide_dotfiles = false,
		hide_gitignored = false,
		hide_ignored = false,
		follow_current_file = {
		    enabled = true,
		    leave_dirs_open = true
		}
	    },
	    window = {
		mappings = {
		    ["p"] = {
			"toggle_preview",
			config = {
			    use_float = true,
			    use_snacks_image = true
			}
		    },
		    ["l"] = "focus_preview",
		    ["<C-u>"] = { "scroll_preview", config = {direction = 15} },
		    ["<C-d>"] = { "scroll_preview", config = {direction = -15} },
		}
	    }
	},
	keys = {
	    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file system" }
	}
    }
}
