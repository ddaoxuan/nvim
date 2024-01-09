require('dave.core.keymaps')

vim.opt.guicursor = ''
vim.o.termguicolors = true

-- [[ Tabs and indentation ]]
vim.opt.autoindent = true -- autoindent enabled
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.smarttab = true -- Enable smart tabbing
vim.o.breakindent = true -- Enable break indent
-- case insensitive search
vim.o.smartcase = true -- Enable smart tabbing
vim.o.ignorecase = true -- Enable smart tabbing

-- [[ Timing ]]
-- Decrease update time
vim.o.updatetime = 50 -- shortens update time
vim.o.timeoutlen = 300 -- shortens key sequence time

-- [[ Misc ]]
vim.opt.colorcolumn = '80' -- Line length marker at 80 columns
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling

vim.o.undofile = true -- Save undo history
vim.o.undodir = vim.fn.stdpath('config') .. '/undo' -- set undo directory
vim.opt.backupskip = '/tmp/*,/private/tmp/*' -- skip backup for specific paths

vim.o.nu = true -- show line numbers
vim.o.relativenumber = true -- enable relative number

vim.o.hlsearch = false -- Set highlight on search
vim.o.incsearch = true -- Makes search act like search in modern browsers

vim.opt.shell = 'fish' -- shell to fish

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local dave_group = augroup('Dave', {})

-- highlight on yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- just to keep autocmds in a single file
-- this attaches keymaps to lsp client
autocmd('LspAttach', {
    group = dave_group,
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<leader>rn', function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set('n', 'gd', function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set('n', 'gr', function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set('n', 'gI', function()
            vim.lsp.buf.implementation()
        end, opts)
        vim.keymap.set('n', '<leader>D', function()
            vim.lsp.buf.type_definition()
        end, opts)
        vim.keymap.set('n', '<C-h>', function()
            vim.lsp.buf.signature_help()
        end, opts)
        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
        end, opts)

        -- [[ Diagnostic keymaps ]]
        vim.keymap.set('n', '<C-p>', function()
            vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set('n', '<C-n>', function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set('n', '<leader>e', function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set('n', '<leader>q', function()
            vim.diagnostic.setloclist()
        end, opts)

        --[[ Misc ]]
        vim.keymap.set('n', '<leader>rs', ':LspRestart<cr>', opts)
    end,
})
