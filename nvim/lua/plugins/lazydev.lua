vim.pack.add({
    "https://github.com/folke/lazydev.nvim",
})

local lazydev = require('lazydev')

require'lazydev'.setup()

vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', { root_dir = function(bufnr, on_dir) on_dir(lazydev.find_workspace(bufnr)) end })
