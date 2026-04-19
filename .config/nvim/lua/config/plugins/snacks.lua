local confirm = function(self)
    local before = vim.api.nvim_list_bufs()
    self:action("confirm")()
    local after = vim.api.nvim_list_bufs()

    if table.concat(before) ~= table.concat(after) and self.meta["is_maximized"] then
	self:action("toggle_maximize")()
    end
end
local toggleMaximize = function(self)
    self.meta["is_maximized"] = self.meta["is_maximized"] ~= true
    self:action("toggle_maximize")()
end

return {
    {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
	    bigfile = { enabled = false },
	    dashboard = { enabled = false },
	    indent = { enabled = false },
	    input = { enabled = false },
	    notifier = { enabled = false },
	    quickfile = { enabled = false },
	    scope = { enabled = false },
	    scroll = { enabled = false },
	    statuscolumn = { enabled = false },
	    words = { enabled = false },
	    image = { },
	    explorer = {
		replace_netrw = true, -- Replace netrw with the snacks explorer
		trash = false -- Use the system trash when deleting files
	    },
	    picker = {
		sources = {
		    explorer = {
			layout = {
			    hidden = { "input" },
			    layout = {
				width = 40,
			    }
			},
			win = {
			    list = {
				keys = {
				    ["q"] = "cancel",
				    ["s"] = confirm,
				    ["<2-LeftMouse>"] = confirm,
				    ["f"] = toggleMaximize,
				    ["h"] = false,
				    ["<M-w>"] = false,
				    ["<C-s>"] = false,
				    ["<C-v>"] = false,
				    ["a"] = "explorer_add",
				    ["Z"] = false,
				    ["c"] = "explorer_copy",
				    ["d"] = "explorer_del",
				    ["]d"] = false,
				    ["[d"] = false,

				    ["]e"] = false,
				    ["[e"] = false,
				    ["."] = false,
				    ["]g"] = false,
				    ["[g"] = false,
				    ["m"] = false,
				    ["o"] = false,
				    ["r"] = "explorer_rename",
				    ["<BS>"] = "explorer_up",
				    ["<CR>"] = "explorer_focus",
				    ["u"] = false,
				    ["]w"] = false,
				    ["[w"] = false,
				    ["y"] = "explorer_yank",

				    ["i"] = false,
				    ["<M-d>"] = false,
				    ["<C-W>J"] = false,
				    ["<C-W>H"] = false,
				    ["<C-W>L"] = false,
				    ["<C-W>K"] = false,
				    ["G"] = false,
				    ["<C-N>"] = false,
				    ["<C-J>"] = false,
				    ["<Down>"] = false,
				    ["j"] = false,
				    ["zb"] = false,
				    ["zz"] = false,
				    ["<C-D>"] = false,

				    ["zt"] = false,
				    ["<C-U>"] = false,
				    ["gg"] = false,
				    ["<C-K>"] = false,
				    ["<C-P>"] = false,
				    ["<Up>"] = false,
				    ["k"] = false,
				    ["<S-CR>"] = false,
				    ["<Space>/"] = false,
				    ["<C-F>"] = false,
				    ["<C-B>"] = false,
				    ["<C-G>"] = false,
				    ["<C-Q>"] = false,
				    ["<C-A>"] = false,

				    ["<Tab>"] = false,
				    ["<S-Tab>"] = false,
				    ["<C-C>"] = false,
				    ["<C-T>"] = false,
				    ["/"] = false,
				    ["<M-f>"] = false,
				    ["?"] = "toggle_help_list",
				    ["H"] = false,
				    ["<M-h>"] = false,
				    ["I"] = false,
				    ["<M-i>"] = false,
				    ["<M-m>"] = false,
				    ["<M-p>"] = false,
				    ["p"] = "toggle_preview",
				    ["l"] = false
				}
			    },
			},
		    }
		}
	    },
	},
	keys = {
	    { "<leader>e", function() require("snacks").explorer({
		follow_file = true,
		watch = true,
		hidden = true,
		ignored = true,
	    }) end, desc = "Open file explorer" },
	    { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find file" },
	    { "<leader>fw", function() require("snacks").picker.grep() end, desc = "Live grep" },
	    { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
	    { "<leader>lr", function() require("snacks").picker.lsp_references() end, desc = "Search LSP references" },
	    { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Search LSP definitions" },
	}
    }
}
