return {
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', function()
                vim.cmd('G stash')
            end, { desc = 'git stash changes' })

            vim.keymap.set('n', '<leader>gp', function()
                vim.cmd('G stash pop')
            end, { desc = 'git pop last stash' })

            vim.keymap.set('n', '<leader>gc', function()
                vim.cmd('G commit')
            end, { desc = 'git commit' })

            vim.keymap.set('n', '<leader>ga', function()
                vim.cmd('Gwrite')
            end, { desc = 'git add current file' })

            vim.keymap.set('n', '<leader>gb', function()
                vim.cmd('G blame')
            end, { desc = 'git blame' })

            vim.keymap.set('n', '<leader>gd', function()
                vim.cmd('Gdiff')
            end, { desc = 'git diff' })

            vim.keymap.set('n', '<leader>gv', function()
                vim.cmd('Gvdiffsplit!')
            end, { desc = 'git diff split' })

            vim.keymap.set('n', '<leader>gl', function()
                vim.cmd('G log')
            end, { desc = 'git log' })

            vim.keymap.set('n', '<leader>gr', function()
                vim.cmd('G rebase -i')
            end, { desc = 'git rebase' })
        end,
    },
}
