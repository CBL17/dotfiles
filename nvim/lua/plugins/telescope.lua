vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.2" },
})

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<C-p>', builtin.find_files, {})

vim.keymap.set('n', '<C-f>g', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-f>d', function()
    builtin.find_files({ search_dirs = { vim.fn.expand('%:p:h') } })
end, { desc = 'Telescope file search in current file\'s directory' })
vim.keymap.set('n', '<C-f>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<C-f>h', builtin.help_tags, { desc = 'Telescope help tags' })

require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            }
        }
    }
}
