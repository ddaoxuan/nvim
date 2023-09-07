return {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'dark', -- other options: 'darker', 'cool', 'deep', 'warm', 'warmer
      term_colors = true,
      -- toggle theme style ---
      toggle_style_key = ';ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>tf"
      toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' }, -- List of styles to toggle between
    }

    require('onedark').load()
  end,
}
