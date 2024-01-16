return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jayp0521/mason-null-ls.nvim', -- formatting etc.

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities
        'hrsh7th/cmp-buffer', -- source for text in buffer
        'hrsh7th/cmp-path', -- source for file system paths
        'hrsh7th/cmp-cmdline', -- source for file system paths

        -- Snippets
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },

    config = function()
        local mason_lspconfig = require('mason-lspconfig')
        local mason = require('mason')
        local mason_null_ls = require('mason-null-ls')
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- mason
        mason.setup({
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        })

        -- define servers
        local servers = {
            tailwindcss = {},
            clangd = {},
            tsserver = {},
            pyright = {},
            rust_analyzer = {},
            lua_ls = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        }

        -- bridge for cmp and lsp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
            require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- bridge for mason and lsp
        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            handlers = {
                function(serverName)
                    require('lspconfig')[serverName].setup({
                        apabilities = capabilities,
                        -- on_attach = attach, -- attach not needed as augroup is made in init.lua for global snippets
                        settings = servers[serverName],
                        filetypes = (servers[serverName] or {}).filetypes,
                    })
                end,
            },
        })

        -- mason-null-ls bridge, kinda wanna get rid of it
        mason_null_ls.setup({
            -- list of formatters & linters for mason to install
            ensure_installed = {
                'prettier', -- ts/js formatter
                'stylua', -- lua formatter
            },
            automatic_installation = true,
        })

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
