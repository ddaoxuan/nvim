return {
    'stevearc/conform.nvim', -- formatter plugin
    config = function()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        local format_group = augroup('format', { clear = true })

        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                javascript = { 'biome-check' },
                typescript = { 'biome-check' },
                javascriptreact = { 'biome-check' },
                typescriptreact = { 'biome-check' },
                json = { 'biome-check' },
                svelte = { 'biome-check' },
                graphql = { 'biome-check' },
                css = { 'biome-check' },
                scss = { 'biome-check' },
                markdown = { 'biome-check' },
                -- terraform
                hcl = { 'packer_fmt' },
                terraform = { 'terraform_fmt' },
                tf = { 'terraform_fmt' },
                ['terraform-vars'] = { 'terraform_fmt' },

                -- javascript = { 'prettier' },
                -- typescript = { 'prettier' },
                -- javascriptreact = { 'prettier' },
                -- typescriptreact = { 'prettier' },
                -- json = { 'prettier' },
                -- svelte = { 'prettier' },
                -- graphql = { 'prettier' },
                -- css = { 'prettier' },
                -- scss = { 'prettier' },
                -- markdown = { 'prettier' },
                --               yaml = { 'yamlfix' },
                toml = { 'taplo' },
                html = { 'htmlbeautifier' },
                lua = { 'stylua' },
            },
        })

        autocmd('BufWritePre', {
            group = format_group,
            callback = function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout = 500,
                })
            end,
        })

        vim.keymap.set('n', '<leader>lf', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout = 500,
            })
        end, { desc = 'format current file' })
    end,
}
