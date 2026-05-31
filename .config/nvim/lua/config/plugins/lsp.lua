---@brief
---
--- https://detachhead.github.io/basedpyright
---
--- `basedpyright`, a static type checker and language server for python
--- Check `:help lspconfig-all` under `basedpyright` for info

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = "basedpyright",
  }
  for _, client in ipairs(clients) do
    if client.settings then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client:notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

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
            vim.lsp.config["terraformls"] = {
                cmd = { "terraform-ls", "serve" },
                filetypes = { "terraform", "terraform-vars" },
                root_markers = { ".terraform", ".git" }
            }
            vim.lsp.config["pyright"] = {
                cmd = { "basedpyright-langserver", "--stdio" },
                filetypes = { "python" },
                root_markers = {
                    "pyrightconfig.json",
                    "pyproject.toml",
                    "setup.py",
                    "setup.cfg",
                    "requirements.txt",
                    "Pipfile",
                    ".git",
                },
                ---@type lspconfig.settings.basedpyright
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = "openFilesOnly",
                            -- https://docs.basedpyright.com/latest/configuration/language-server-settings/
                            -- Explicitly setting `basedpyright.analysis.useLibraryCodeForTypes` is **discouraged** by the official docs.
                            -- Because it will override per-project configurations like `pyproject.toml`.
                            -- If left unset, its default value is `true`, and it can be correctly overridden by project config files.
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
                        local params = {
                            command = "basedpyright.organizeimports",
                            arguments = { vim.uri_from_bufnr(bufnr) },
                        }

                        -- Using client.request() directly because "basedpyright.organizeimports" is private
                        -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
                        -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
                        ---@diagnostic disable-next-line: param-type-mismatch
                        client.request("workspace/executeCommand", params, nil, bufnr)
                    end, {
                        desc = "Organize Imports",
                    })

                    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
                        desc = "Reconfigure basedpyright with the provided python path",
                        nargs = 1,
                        complete = "file",
                    })
                end,
            }
        end
    },
}
