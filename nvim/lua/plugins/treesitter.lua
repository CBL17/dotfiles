vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ts = require("nvim-treesitter")

ts.install({
    "c",
    "asm",
    "bash",
    "cmake",
    "cpp",
    "gitcommit",
    "gitignore",
    "json",
    "nasm",
    "objdump",
    "python",
    "zig",
})

local function start(buf)
    if pcall(vim.treesitter.start, buf) then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
            return
        end

        -- auto_install: fetch missing parsers on first use
        if not vim.tbl_contains(ts.get_installed(), lang)
            and vim.tbl_contains(ts.get_available(), lang) then
            ts.install(lang):await(vim.schedule_wrap(function()
                if vim.api.nvim_buf_is_valid(args.buf) then
                    start(args.buf)
                end
            end))
            return
        end

        start(args.buf)
    end,
})
