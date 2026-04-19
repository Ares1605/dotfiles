return {
    {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
	    {
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
		    library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		    },
		},
	    },
	},
	config = function()
	    vim.lsp.config["intelephense"] = {
		cmd = { "intelephense", "--stdio" },
		filetypes = { "php" },
		root_markers = { ".git", "composer.json" },
		telemetry = {
		    enabled = false
		}
	    }
	    vim.lsp.config["vtsls"] = {
		cmd = { "vtsls", "--stdio" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		init_options = {
		    hostInfo = "neovim"
		}
	    }
	    vim.lsp.config["lua_ls"] = {
		-- Command and arguments to start the server.
		cmd = { "lua-language-server" },
		-- Filetypes to automatically attach to.
		filetypes = { "lua" },
		-- Sets the "workspace" to the directory where any of these files is found.
		-- Files that share a root directory will reuse the LSP server connection.
		-- Nested lists indicate equal priority, see |vim.lsp.Config|.
		root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
		-- Specific settings to send to the server. The schema is server-defined.
		-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
		settings = {
		    Lua = {
			runtime = {
			    version = "LuaJIT",
			}
		    }
		}
	    }
	end
    },
}
