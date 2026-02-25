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
            'datsfilipe/vesper.nvim',
            'morhetz/gruvbox',
            'sainnhe/everforest',
            'rebelot/kanagawa.nvim',
            'rose-pine/neovim',
        },
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            -- transparent bg
            -- vim.cmd('autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE')
            -- set colorscheme
            vim.cmd('colorscheme rose-pine-moon')
        end,
    },
}
