return {
    {
        'saecki/crates.nvim',
        ft = { 'toml' },
        config = function()
            require('crates').setup({
                completion = {
                    cmp = {
                        enabled = true,
                    },
                },
            })

            require('cmp').setup.buffer({
                sources = {
                    { name = 'crates' },
                },
            })
        end,
    },
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        config = function()
            vim.g.rustfmt_autosave = true
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = true, -- make sure mason had time to load
        ft = 'rust',
        config = function()
            local mason_registry = require('mason-registry')
            local codelldb = mason_registry.get_package('codelldb')
            local extension_path = codelldb:get_install_path() .. '/extension/'
            local codelldb_path = extension_path .. 'adapter/codelldb'
            local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
            -- If you are on Linux, replace the line above with the line below:
            -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
            local cfg = require('rustaceanvim.config')

            vim.g.rustaceanvim = {
                dap = {
                    adapter = cfg.get_codelldb_adapter(
                        codelldb_path,
                        liblldb_path
                    ),
                },
            }
        end,
    },
}
