vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "neocmake",
        "ty",
        "rust_analyzer",
        "zls",
    },
    automatic_enable = {
        exclude = {
        }
    }
})
