return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason-lspconfig.nvim',
        'williamboman/mason.nvim',
        'j-hui/fidget.nvim',
    },

    config = function()
        local builtin = require('telescope.builtin')
        local mason_lspconfig = require('mason-lspconfig') -- Ensure the servers above are installed
        local luasnip = require('luasnip')

        local attach = function(_, bufnr)
            --[[ LSP specific keymaps]]
            vim.keymap.set(
                'n',
                '<leader>rn',
                vim.lsp.buf.rename,
                { desc = 'Rename' }
            )
            vim.keymap.set(
                'n',
                '<leader>ca',
                vim.lsp.buf.code_action,
                { desc = '[C]ode [A]ction' }
            )
            vim.keymap.set(
                'n',
                'gd',
                vim.lsp.buf.definition,
                { desc = '[G]oto [D]efinition' }
            )
            vim.keymap.set(
                'n',
                'gI',
                vim.lsp.buf.implementation,
                { desc = '[G]oto [I]mplementation' }
            )
            vim.keymap.set(
                'n',
                '<leader>D',
                vim.lsp.buf.type_definition,
                { desc = 'Type [D]efinition' }
            )
            vim.keymap.set(
                'n',
                'K',
                vim.lsp.buf.hover,
                { desc = 'Hover Documentation' }
            ) -- See `:help K` for why this keymap

            -- [[ Diagnostic keymaps ]]
            vim.keymap.set(
                'n',
                '[d',
                vim.diagnostic.goto_prev,
                { desc = 'Go to previous diagnostic message' }
            )
            vim.keymap.set(
                'n',
                ']d',
                vim.diagnostic.goto_next,
                { desc = 'Go to next diagnostic message' }
            )
            vim.keymap.set(
                'n',
                '<leader>e',
                vim.diagnostic.open_float,
                { desc = 'Open floating diagnostic message' }
            )
            vim.keymap.set(
                'n',
                '<leader>q',
                vim.diagnostic.setloclist,
                { desc = 'Open diagnostics list' }
            )

            --[[ Misc ]]
            vim.keymap.set(
                'n',
                'gr',
                builtin.lsp_references,
                { desc = '[G]oto [R]eferences' }
            )
            vim.keymap.set(
                'n',
                '<leader>ds',
                builtin.lsp_document_symbols,
                { desc = '[D]ocument [S]ymbols' }
            )
            vim.keymap.set(
                'n',
                '<leader>rs',
                ':LspRestart<cr>',
                { desc = 'Restart LSPs' }
            )

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        -- Switch for controlling whether you want autoformatting.
        --  Use :KickstartFormatToggle to toggle autoformatting on or off
        local format_is_enabled = true
        vim.api.nvim_create_user_command('KickstartFormatToggle', function()
            format_is_enabled = not format_is_enabled
            print('Setting autoformatting to: ' .. tostring(format_is_enabled))
        end, {})
        --
        -- -- Create an augroup that is used for managing our formatting autocmds.
        -- --      We need one augroup per client to make sure that multiple clients
        -- --      can attach to the same buffer without interfering with each other.
        -- local _augroups = {}
        -- local get_augroup = function(client)
        --   if not _augroups[client.id] then
        --     local group_name = 'kickstart-lsp-format-' .. client.name
        --     local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        --     _augroups[client.id] = id
        --   end
        --
        --   return _augroups[client.id]
        -- end
        --
        -- bridge for cmp and lsp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
            require('cmp_nvim_lsp').default_capabilities(capabilities)

        --[[ Configure Servers ]]

        local servers = {
            tailwindcss = {},
            lua_ls = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true,
                        },
                    },
                    telemetry = { enable = false },
                },
            },
        }

        luasnip.config.setup({})

        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
        })
        mason_lspconfig.setup_handlers({
            function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = capabilities,
                    on_attach = attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        })

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
    end,
}
