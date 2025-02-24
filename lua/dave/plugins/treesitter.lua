return {
    -- Syntax Highlight, edit, and navigate code % etc
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- treesitter update not typescript update ..
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
                'jsdoc',
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
