local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'nvim-lua/plenary.nvim', -- lua functions that many plugins use
    'github/copilot.vim', -- copilot / using supermaven instead
    'numToStr/Comment.nvim',
    { import = 'dave.plugins' },
    { import = 'dave.plugins.lsp' },
    { import = 'dave.plugins.rust' },
}, {
    checker = {
        enabled = true,
        notify = true,
    },
    change_detection = {
        notify = false, -- disable notifications every time lazy makes updates
    },
})
