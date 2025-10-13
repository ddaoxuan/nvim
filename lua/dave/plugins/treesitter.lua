return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'c',
                'cpp',
                'lua',
                'python',
                'rust',
                'javascript',
                'typescript',
                'vim',
                'vimdoc',
                'jsdoc',
            },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = false,
                    goto_next_start = {
                        [')'] = '@function.outer',
                        ['}'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['('] = '@function.outer',
                        ['{'] = '@class.outer',
                    },
                    goto_next_end = {
                        ['ga'] = '@parameter.outer', -- extend/jump forward param
                    },
                    goto_previous_start_extra = {
                        ['gA'] = '@parameter.outer', -- extend/jump backward param
                    },
                },
            },
        })
    end,
}
