return {
    'MagicDuck/grug-far.nvim',
    version = '1.6.3', -- Pin to 0.10.x compatible version
    config = function()
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
            -- engine = 'ripgrep' is default, but 'astgrep' can be specified uses rg as command
        })

        local grug = require('grug-far')

        vim.keymap.set('n', '<leader>sr', function()
            grug.open()
        end, { desc = '[S]earch and [R]eplace' })

        -- vim.keymap.set('n', '<leader>sw', function()
        --     grug.open({ prefills = { search = vim.fn.expand('<cword>') } })
        -- end, { desc = '[S]earch and replace current [W]ord' })

        vim.keymap.set('v', '<leader>sr', function()
            grug.with_visual_selection()
        end, { desc = '[S]earch and [R]eplace selection' })
    end,
}
