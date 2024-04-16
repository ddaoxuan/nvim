return {
    'nvimtools/none-ls.nvim', -- configure formatters & linters
    dependencies = {
        'nvimtools/none-ls-extras.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local null_ls = require('null-ls')
        local null_ls_utils = require('null-ls.utils')
        local formatting = null_ls.builtins.formatting -- to setup formatters

        -- to setup format on save
        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

        -- configure null_ls
        null_ls.setup({
            -- add package.json as identifier for root (for typescript monorepos)
            root_dir = null_ls_utils.root_pattern(
                '.null-ls-root',
                'Makefile',
                '.git',
                'package.json'
            ),

            -- setup formatters & linters
            sources = {
                --  to disable file types use
                --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
                formatting.prettier, -- js/ts formatter -- no need to call it is part of builtins (see null-ls docs)
                formatting.stylua, -- lua formatter
                -- eslint_d no longer comes from built ins
                require('none-ls.diagnostics.eslint_d').with({
                    diagnostics_format = '[eslint] #{m}\n(#{c})',
                    condition = function(utils)
                        return utils.root_has_file({
                            '.eslintrc.js',
                            '.eslintrc.cjs',
                        })
                    end,
                }),
                formatting.gofumpt, -- go formatter
                formatting.goimports_reviser, -- go formatter for imports sorting
                formatting.golines, -- go line formatter
            },

            -- configure format on save
            on_attach = function(current_client, bufnr)
                if
                    -- do not format if disabled
                    current_client.supports_method('textDocument/formatting')
                then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                filter = function(client)
                                    --  only use null-ls for formatting instead of lsp server
                                    return client.name == 'null-ls'
                                end,
                                bufnr = bufnr,
                            })
                        end,
                    })
                end
            end,
        })
    end,
}
