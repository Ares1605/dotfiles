local languages = {
    "lua",
    "vim",
    "php",
    "python",
    "javascript",
    "bash",
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
    "yaml",
    "latex",
    "typescript",
    "typst",
    "vue",
    "zsh",
    "bash",
    "make",
    "mermaid",
    "regex"
}

local installed_languages = {}
for _, language in ipairs(languages) do
    installed_languages[language] = true
end

local function should_disable_highlight(buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local fs_stat = (vim.uv or vim.loop).fs_stat
    local ok, stats = pcall(fs_stat, vim.api.nvim_buf_get_name(buf))
    return ok and stats and stats.size > max_filesize
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ok, treesitter = pcall(require, "nvim-treesitter")
            if ok and type(treesitter.install) == "function" then
                treesitter.install(languages)
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
                callback = function(event)
                    local filetype = vim.bo[event.buf].filetype
                    local language = vim.treesitter.language.get_lang(filetype) or filetype

                    if not installed_languages[language] or should_disable_highlight(event.buf) then
                        return
                    end

                    local ok = pcall(vim.treesitter.start, event.buf, language)
                    if ok then
                        vim.bo[event.buf].syntax = "ON"
                    end
                end,
            })
        end,
    },
}
