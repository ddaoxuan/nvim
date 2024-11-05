return {
    'szw/vim-maximizer',
    config = function()
        vim.keymap.set('n', '<leader>m', function()
            vim.cmd('MaximizerToggle')
        end, { desc = 'toggle maximizer' })
    end,
}
