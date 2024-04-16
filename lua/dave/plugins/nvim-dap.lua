return {
    'leoluz/nvim-dap-go',
    ft = {
        'go',
    },
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    config = function()
        local dap_go = require('dap-go')
        dap_go.setup()

        vim.keymap.set(
            'n',
            '<leader>db',
            '<cmd> DapToggleBreakpoint <CR>',
            { desc = 'Add breakpoint at a line' }
        )
        vim.keymap.set('n', '<leader>dus', function()
            local widgets = require('dap.ui.widgets')
            local sidebar = widgets.sidebar(widgets.scopes)
            sidebar.open()
        end, { desc = 'Open debugging sidebar' })
        vim.keymap.set('n', '<leader>dgt', function()
            require('dap-go').debug_test()
        end, {
            desc = 'Debug go test',
        })

        vim.keymap.set('n', '<leader>dgl', function()
            require('dap-go').debug_last()
        end, { desc = 'Debug last go test' })
    end,
}
