return {
    'tpope/vim-fugitive', -- Git related plugins
    config = function()
        vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    end,
}
