local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup{
    ensure_installed = {
        'bashls',
        'clangd',
        'cmake',
        'lua_ls',
        'jedi_language_server',
        'robotframework_ls',
        'zls',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function ()
            require('lspconfig').lua_ls.setup({
                on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                  return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  runtime = {
                    version = 'LuaJIT'
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = {
                      vim.env.VIMRUNTIME
                    }
                  }
                })
                end,
                settings = {
                Lua = {}
                }
            })
        end
    }
}
