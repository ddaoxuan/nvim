-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'dw', 'vb"_d') -- Delete a word backwards

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- New tab
vim.keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true }) -- horizontal split
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w)w', { silent = true }) -- vertical split

-- Move window
vim.keymap.set('', 'sh', '<C-w>h')
vim.keymap.set('', 'sk', '<C-w>k')
vim.keymap.set('', 'sj', '<C-w>j')
vim.keymap.set('', 'sl', '<C-w>l')

-- Resize window
vim.keymap.set('n', '<C-w><left>', '<C-w><')
vim.keymap.set('n', '<C-w><right>', '<C-w>>')
vim.keymap.set('n', '<C-w><up>', '<C-w>-')
vim.keymap.set('n', '<C-w><down>', '<C-w>+')
vim.keymap.set('n', 'dw', 'vb"_d') -- Delete a word backwards
vim.keymap.set('n', '<C-a>', 'gg<S-v>G') --Select all
-- Open explorer
vim.keymap.set('n', '<leader>fb', ':Explore<CR>')
