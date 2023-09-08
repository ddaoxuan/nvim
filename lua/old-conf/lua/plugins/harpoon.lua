return {
  'ThePrimeagen/harpoon',
  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    vim.keymap.set('n', 'sc', require('harpoon.mark').add_file)
    vim.keymap.set('n', 'sa', require('harpoon.ui').nav_prev)
    vim.keymap.set('n', 'sd', require('harpoon.ui').nav_next)
    vim.keymap.set('n', 'sq', require('harpoon.ui').toggle_quick_menu)
  end,
}
