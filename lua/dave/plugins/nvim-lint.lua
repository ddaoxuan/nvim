return {
    'mfussenegger/nvim-lint', -- complementary to lsp, where just lsp is not enough or linter works better
    config = function()
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        local lint_group = augroup('lint', { clear = true })
        local lint = require('lint')

        lint.linters_by_ft = {

            -- javascript = { 'biomejs' },
            -- typescript = { 'biomejs' },
            -- javascriptreact = { 'biomejs' },
            -- typescriptreact = { 'biomejs' },

            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            --
            -- svelte = { 'eslint_d' },
        }

        autocmd('BufWritePre', {
            group = lint_group,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set('n', '<leader>ll', function()
            lint.try_lint()
        end, { desc = 'lint current file' })
    end,
}
