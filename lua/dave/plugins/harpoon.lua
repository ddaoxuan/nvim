return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup()

        vim.keymap.set('n', '<leader>a', function()
            harpoon:list():append()
        end)
        vim.keymap.set('n', '<C-e>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set('n', 'sa', function()
            harpoon:list():prev()
        end)
        vim.keymap.set('n', 'sd', function()
            harpoon:list():next()
        end)

        -- old config
        -- vim.keymap.set('n', 'sc', require('harpoon.mark').add_file)
        -- vim.keymap.set('n', 'sa', require('harpoon.ui').nav_prev)
        -- vim.keymap.set('n', 'sd', require('harpoon.ui').nav_next)
        -- vim.keymap.set('n', '<C-e>', require('harpoon.ui').toggle_quick_menu)
    end,
}
