return {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = {
                'c',
                'cpp',
                'lua',
                'python',
                'rust',
                'javascript',
                'typescript',
                'vimdoc',
                'vim',
            },

            sync_install = true,
            auto_install = false,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
