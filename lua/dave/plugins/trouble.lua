return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        vim.keymap.set('n', '<leader>dq', function()
            require('trouble').toggle('quickfix')
        end, { desc = 'trobule qf list' })
    end,
}
