return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jay-babu/mason-null-ls.nvim',
    },

    config = function()
        local mason_lspconfig = require('mason-lspconfig')
        local mason = require('mason')
        local mason_null_ls = require('mason-null-ls')
        local cmp_lsp = require('cmp_nvim_lsp')
        local servers = {
            tailwindcss = {},
            clangd = {},
            pyright = {},
            gopls = {
                filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
                cmd = { 'gopls' },
            },
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

        mason.setup({
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        })

        -- bridge for cmp and lsp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_lsp.default_capabilities(capabilities)

        -- bridge for mason and lsp
        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            handlers = {
                function(serverName)
                    require('lspconfig')[serverName].setup({
                        capabilities = capabilities,
                        -- on_attach = attach, -- attach not needed as augroup is made in init.lua for global snippets
                        settings = servers[serverName],
                        filetypes = (servers[serverName] or {}).filetypes,
                    })
                end,
            },
        })

        -- bridge for mason-null-ls, kinda wanna get rid of it
        mason_null_ls.setup({
            -- list of formatters & linters for mason to install
            ensure_installed = nil,
            automatic_installation = true,
        })
    end,
}
