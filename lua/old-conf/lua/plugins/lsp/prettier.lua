return {

  'MunifTanjim/prettier.nvim', -- Prettier plugin for neovim's built-in LSP client
  config = function()
    local prettier = require 'prettier'
    prettier.setup {
      bin = 'prettierd',
      filetypes = {
        'css',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'scss',
        'less',
      },
    }
  end,
}
