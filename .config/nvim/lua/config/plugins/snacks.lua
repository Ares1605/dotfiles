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
            dashboard = {
                enabled = true,
                width = 60,
                row = nil, -- dashboard position. nil for center
                col = nil, -- dashboard position. nil for center
                pane_gap = 4, -- empty columns between vertical panes
                autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
                -- These settings are used by some built-in sections
                preset = {
                    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                    ---@type fun(cmd:string, opts:table)|nil
                    pick = nil,
                    -- Used by the `keys` section to show keymaps.
                    -- Set your custom keymaps here.
                    -- When using a function, the `items` argument are the default keymaps.
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    -- Used by the `header` section
                    header = [[
   .=**############*.                                                                   
 .=#*=. :*##+.  -*#=                                                                    
 .*##=..+##*=   ....             .-+:                      .=-.          :=++. .=*+=.   
  ...  -*##*:             :+*######=.      :+*##-  .-*#*:.+##*:.-*=.  .=*###--*####*-.  
      .+####*****=.     -*#+. .=##*:     :+**##+.  :*##=.-*#####*-.  =*==##+**:.=##*:   
      :*##*: .:.      .+#*-.  -*#*-.    +*==##*:  .*##+:  =###*-.  -*+..*###+. .*##=.   
      =###+          .*##=.  -###*:   =#+.:+##=. .*###=.  :##=    :+- .-###+.  =##*:    
.=+. :+##*:          =##*: :+*+##=.:**-  .-##*-.-*+##*-  :*#=         .+##*:  :*##+.:+*-
=##*-+##*:          .=#####*= *####*=.   .=#####+.:*######*:          -##*-.  -#####*=. 
 .+***=.             .=**+-.  -**+-.      .=**=.   .+***=.           .+*-.     =**+-.   
                    ]]
                },
                -- item field formatters
                formats = {
                    icon = function(item)
                        if item.file and item.icon == "file" or item.icon == "directory" then
                            return Snacks.dashboard.icon(item.file, item.icon)
                        end
                        return { item.icon, width = 2, hl = "icon" }
                    end,
                    footer = { "%s", align = "center" },
                    header = { "%s", align = "center" },
                    file = function(item, ctx)
                        local fname = vim.fn.fnamemodify(item.file, ":~")
                        fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                        if #fname > ctx.width then
                            local dir = vim.fn.fnamemodify(fname, ":h")
                            local file = vim.fn.fnamemodify(fname, ":t")
                            if dir and file then
                                file = file:sub(-(ctx.width - #dir - 2))
                                fname = dir .. "/…" .. file
                            end
                        end
                        local dir, file = fname:match("^(.*)/(.+)$")
                        return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
                    end,
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                },
            },
            indent = { enabled = false },
            input = { enabled = false },
            notifier = { enabled = false },
            quickfile = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = {
                enabled = true,
            },
            image = { enabled = true },
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
            { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
            { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find file" },
            { "<leader>fF", function() require("snacks").picker.files({
                cwd = "~"
            }) end, desc = "Global Find file" },
            { "<leader>fw", function() require("snacks").picker.grep() end, desc = "Live grep" },
            { "<leader>fW", function() require("snacks").picker.grep({
                cwd = "~"
            }) end, desc = "Global Live grep" },
            { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
            { "<leader>lr", function() require("snacks").picker.lsp_references() end, desc = "Search LSP references" },
            { "<leader>li", function() require("snacks").picker.lsp_implementations() end, desc = "Search LSP references" },
            { "<leader>ls", function() require("snacks").picker.lsp_symbols() end, desc = "Search LSP references" },
            { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Search LSP definitions" },
            { "[w", function() require("snacks").words.jump(-1, false) end, desc = "Move LSP reference left under cursor" },
            { "]w", function() require("snacks").words.jump(1, false) end, desc = "Move LSP reference right under cursor" },
        }
    }
}
