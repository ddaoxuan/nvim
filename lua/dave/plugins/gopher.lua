return {
    'olexsmir/gopher.nvim',
    ft = 'go',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('gopher').setup()
    end,
    build = function()
        vim.cmd([[ silent! GoInstallDeps]])
    end,
}
