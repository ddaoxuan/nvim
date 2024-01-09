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
        -- Show lsps init dialog
        -- 'j-hui/fidget.nvim',
    },

    config = function()
        local mason_lspconfig = require('mason-lspconfig')
        local mason = require('mason')
        local mason_null_ls = require('mason-null-ls')
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- require('fidget').setup()

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
                'eslint_d', -- ts/js linter
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

-- -- Switch for controlling whether you want autoformatting.
-- --  Use :KickstartFormatToggle to toggle autoformatting on or off
-- local format_is_enabled = true
-- vim.api.nvim_create_user_command('KickstartFormatToggle', function()
--     format_is_enabled = not format_is_enabled
--     print('Setting autoformatting to: ' .. tostring(format_is_enabled))
-- end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
-- local _augroups = {}
-- local get_augroup = function(client)
--     if not _augroups[client.id] then
--         local group_name = 'kickstart-lsp-format-' .. client.name
--         local id =
--             vim.api.nvim_create_augroup(group_name, { clear = true })
--         _augroups[client.id] = id
--     end
--
--     return _augroups[client.id]
-- end

-- Get back to this, currently there's no need to attach autoformatting, it is handled via null-ls
-- Whenever an LSP attaches to a buffer, we will run this function.
-- See `:help LspAttach` for out this autocmd event.
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
--   -- This is where we attach the autoformatting for reasonable clients
--   callback = function(args)
--     local client_id = args.data.client_id
--     local client = vim.lsp.get_client_by_id(client_id)
--     local bufnr = args.buf
--
--     -- Only attach to clients that support document formatting
--     if not client.server_capabilities.documentFormattingProvider then
--       return
--     end
--
--     -- Tsserver usually works poorly. Sorry you work with bad languages
--     -- You can remove this line if you know what you're doing :)
--     if client.name == 'tsserver' then
--       return
--     end
--
--     -- Get back to this once null-ls solution will be sorted this is currently conflicting with null-ls and for web we use prettier as formatting where lsp would be TS
--
--     -- Create an autocmd that will run *before* we save the buffer.
--     --  Run the formatting command for the LSP that has just attached.
--     -- vim.api.nvim_create_autocmd('BufWritePre', {
--     --   group = get_augroup(client),
--     --   buffer = bufnr,
--     --   callback = function()
--     --     if not format_is_enabled then
--     --       return
--     --     end
--     --
--     --     vim.lsp.buf.format {
--     --       async = false,
--     --       filter = function(c)
--     --         return c.id == client.id
--     --       end,
--     --     }
--     --   end,
--     -- })
--   end,
-- })
