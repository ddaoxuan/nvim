return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local cmp_lsp = require('cmp_nvim_lsp')

        -- bridge for cmp & lsp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_lsp.default_capabilities(capabilities)

        -- autocompletion setup
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select), -- prev suggestion
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select), -- next suggestion
                ['<C-Space>'] = cmp.mapping.complete(), -- Show completion window
                ['<C-q>'] = cmp.mapping.abort(), -- close completion window
                ['<C-y>'] = cmp.mapping.confirm({
                    select = true,
                }),
            }),
            -- sources for completion
            sources = {
                { name = 'nvim_lsp' }, -- lsp
                { name = 'luasnip' }, -- snippets
            },
            {
                { name = 'buffer' }, -- text within current buffer
            },
        })
    end,
}
