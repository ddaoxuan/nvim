vim.cmd 'autocmd!'

-- [[ Setting options ]]
-- See `:help vim.o`

-- [[ Encoding ]]
-- vim.scriptencoding = 'utf-8'
-- vim.opt.encoding = 'utf-8'
-- vim.opt.fileencoding = 'utf-8'

-- [[ UI/UX ]]
vim.o.hlsearch = false -- Set highlight on search
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.termguicolors = true -- NOTE: You should make sure your terminal supports this, enables true color
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.wo.number = true -- Show line numbers
vim.opt.backspace = 'start,eol,indent' -- Customize backspace behaviour, enable backspace over start of insert line end nad indent

vim.opt.listchars:append 'space:⋅' -- add dot to listchars for space
vim.opt.listchars:append 'eol:↴' -- add arrow to listchars for enters

-- [[ Searching ]]
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.path:append { '**' } -- Finding files - search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' } -- Ignore node modules while performing file search

-- [[ Tabs and indentation ]]
vim.opt.autoindent = true -- autoindent enabled
vim.opt.shiftwidth = 4 -- 4 space indents
vim.opt.tabstop = 4 -- 4 space indendts
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.smarttab = true -- Enable smart tabbing
vim.o.breakindent = true -- Enable break indent

-- [[ Timing ]]
-- Decrease update time
vim.o.updatetime = 250 -- shortens update time
vim.o.timeoutlen = 300 -- shortens key sequence time

-- [[ Completion ]]
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Misc ]]
vim.o.undofile = true -- Save undo history
vim.o.relativenumber = true -- enable relative number
vim.opt.backupskip = '/tmp/*,/private/tmp/*' -- skip backup for specific paths
vim.opt.showcmd = true --  Show partial commands
vim.opt.cmdheight = 1 -- Set cli height to 1
vim.opt.laststatus = 2 -- always show status line
vim.opt.scrolloff = 10 -- Keep 10 lines visible when scrolling
vim.opt.shell = 'fish' -- shell to fish
vim.opt.inccommand = 'split' -- Shows the effect of the command incrementally

-- [[ Clipboard ]]
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'
