require('dave.core.keymaps')
require('dave.core.autocmds')

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

vim.opt.shell = 'zsh' -- shell to fish

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- editorconfig
vim.g.editorconfig = true
