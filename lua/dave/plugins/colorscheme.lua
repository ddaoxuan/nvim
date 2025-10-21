return {
    -- {
    --     name = 'gruvbox',
    --     priority = 1000,
    --     config = function()
    --         -- set transparent bg
    --         -- vim.cmd('let g:gruvbox_transparent_bg = 1')
    --         -- vim.cmd('autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE')
    --         -- set colorscheme
    --         vim.cmd('colorscheme gruvbox')
    --     end,
    -- },
    {
        'folke/tokyonight.nvim',
        dependencies = {
            'bettervim/yugen.nvim',
            'morhetz/gruvbox',
            'kyazdani42/blue-moon',
            'sainnhe/everforest',
            'nyoom-engineering/oxocarbon.nvim',
            'olivercederborg/poimandres.nvim',
            'datsfilipe/vesper.nvim',
        },
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            -- transparent bg
            -- vim.cmd('autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE')
            -- set colorscheme
            vim.cmd('colorscheme everforest')
        end,
    },
}
