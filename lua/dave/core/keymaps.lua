vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- disable space as used as leader
-- vim.keymap.set('n', '<leader>ex', vim.cmd.Ex) -- explorer (netrw)
vim.keymap.set('n', 'dw', 'vb"_d') -- Delete a word backwards
vim.keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true }) -- horizontal split
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w)w', { silent = true }) -- vertical split
vim.keymap.set('n', '<C-a>', 'gg<S-v>G') --Select all

-- Move between splits
vim.keymap.set('', 'sh', '<C-w>h') -- move left
vim.keymap.set('', 'sk', '<C-w>k') -- move up
vim.keymap.set('', 'sj', '<C-w>j') -- move down
vim.keymap.set('', 'sl', '<C-w>l') -- move right

--Center cursor when moving up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Center cursor when moving between selections
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- qf list next/prev
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')
-- loc list next/prev
vim.keymap.set('n', '<leader>j', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<CR>zz')

-- move lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('x', '<leader>p', '"_dP') -- paste without yanking

-- Copy to system clipboard
vim.keymap.set(
    { 'n', 'v' },
    '<leader>y',
    [["+y]],
    { desc = 'Copy to system clipboard' }
)
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set(
    'n',
    '<leader>s',
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace current word' }
)

-- formatting
-- vim.keymap.set("n", "<leader>o", vim.lsp.buf.format)
