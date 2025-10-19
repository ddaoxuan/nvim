return {
    -- {
    --     'morhetz/gruvbox',
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
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            -- set colorscheme
            vim.cmd('colorscheme tokyonight-moon')
        end,
    },
}
