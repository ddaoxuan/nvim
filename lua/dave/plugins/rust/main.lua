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
            local extension_path = vim.fn.stdpath('data')
                .. '/mason/packages/codelldb/extension/'
            local codelldb_path = extension_path .. 'adapter/codelldb'
            local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
            -- If you are on Linux, replace the line above with the line below:
            -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
            if vim.fn.filereadable(codelldb_path) == 0 then
                vim.notify(
                    'codelldb not installed; rustaceanvim dap disabled',
                    vim.log.levels.WARN
                )
                return
            end
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
