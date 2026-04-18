return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require"nvim-treesitter.configs".setup {
				ensure_installed = {
					"lua",
					"vim",
					"php",
					"python",
					"javascript",
					"bash",
					"typescript",
					"html",
					"scss",
					"css",
					"json",
					"go",
					"dockerfile",
					"nginx",
					"sql",
					"xml",
					"markdown",
					-- I honestly don't know if jsdoc or phpdoc will interfere with php or js,
					-- or what additional support they offer
					"phpdoc",
					"jsdoc",
					"svelte",
					"toml",
					"yaml"
				},
				auto_install = false,
				highlight = {
					disable = function (lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = true,
				},
			}
		end
	}
}

