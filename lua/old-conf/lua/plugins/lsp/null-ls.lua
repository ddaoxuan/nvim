return {

  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      -- autoformatting on save
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_command [[augroup Format]]
          vim.api.nvim_command [[autocmd! * <buffer>]]
          vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
          vim.api.nvim_command [[augroup END]]
        end
      end,
      sources = {
        null_ls.builtins.diagnostics.eslint_d.with {
          diagnostics_format = '[eslint] #{m}\n(#{c})',
        },
        null_ls.builtins.diagnostics.actionlint,
      },
    }
  end,
}
