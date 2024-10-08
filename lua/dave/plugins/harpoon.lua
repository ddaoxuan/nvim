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
        end, { desc = 'add to harpoon' })
        vim.keymap.set('n', '<C-e>', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = 'toggle harpoon' })

        vim.keymap.set('n', 'sa', function()
            harpoon:list():prev()
        end, { desc = 'prev harpoon item' })
        vim.keymap.set('n', 'sd', function()
            harpoon:list():next()
        end, { desc = 'next harpoon item' })
    end,
}
