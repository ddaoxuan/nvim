return {
    'neovim/nvim-lspconfig',
    version = '1.8.0',
    dependencies = {
        'williamboman/mason.nvim',
        { 'williamboman/mason-lspconfig.nvim', version = '1.32.0' },
    },

    config = function()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        local lsp_group = augroup('lsp', {})

        local servers = {
            rust_analyzer = {},
            tailwindcss = {},
            clangd = {},
            pyright = {},
            lua_ls = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
            biome = {
                cmd = { 'biome', 'lsp-proxy' },
                filetypes = {
                    'astro',
                    'css',
                    'graphql',
                    'javascript',
                    'javascriptreact',
                    'json',
                    'jsonc',
                    'svelte',
                    'typescript',
                    'typescript.tsx',
                    'typescriptreact',
                    'vue',
                },
            },
        }

        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')

        mason.setup({
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        })
        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            handlers = {
                function(serverName)
                    if serverName == 'rust_analyzer' then
                        return
                    end
                    require('lspconfig')[serverName].setup({
                        capabilities = require('cmp_nvim_lsp').default_capabilities(
                            vim.lsp.protocol.make_client_capabilities()
                        ),
                        -- on_attach = attach, -- attach not needed as augroup is made in init.lua for global snippets
                        settings = servers[serverName],
                        filetypes = (servers[serverName] or {}).filetypes,
                    })
                end,
            },
        })

        -- this attaches keymaps to lsp client
        autocmd('LspAttach', {
            group = lsp_group,
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', '<leader>rn', function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set('n', 'gd', function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set('n', 'gr', function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set('n', 'gI', function()
                    vim.lsp.buf.implementation()
                end, opts)
                vim.keymap.set('n', '<leader>D', function()
                    vim.lsp.buf.type_definition()
                end, opts)
                vim.keymap.set('n', 'K', function()
                    vim.lsp.buf.hover()
                end, opts)

                -- [[ Diagnostic keymaps ]]
                vim.keymap.set('n', '<C-p>', function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set('n', '<C-n>', function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set('n', '<leader>e', function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set('n', '<leader>q', function()
                    vim.diagnostic.setloclist()
                end, opts)

                --[[ Misc ]]
                vim.keymap.set('n', '<leader>rs', ':LspRestart<cr>', opts)
            end,
        })
    end,
}
