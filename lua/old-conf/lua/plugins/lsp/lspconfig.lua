return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local lsp = require 'lspconfig'
    local protocol = require 'vim.lsp.protocol'
    local capabilities = protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach = function(client, bufnr)
      -- formatting on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]] -- check gh repo for configuring lsp.buf.format()
        vim.api.nvim_command [[augroup END]]
      end
    end

    --[[ Setup servers ]]
    lsp.tsserver.setup {
      root_dir = lsp.util.root_pattern '.git',
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
      cmd = { 'typescript-language-server', '--stdio' },
    }

    lsp.sumneko_lua.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            -- Get the language server to recognize the 'vim' global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
        },
      },
    }

    lsp.eslint.setup {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    }

    lsp.clangd.setup {
      root_dir = lsp.util.root_pattern('compile_commands.json', '.git'),
      on_attach = on_attach,
      capabilities = {
        offsetEncoding = 'utf-8',
      },
    }

    local servers = { 'prismals', 'jsonls' }

    for _, lspServer in pairs(servers) do
      lsp[lspServer].setup {
        root_dir = lsp.util.root_pattern '.git',
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end,
}
