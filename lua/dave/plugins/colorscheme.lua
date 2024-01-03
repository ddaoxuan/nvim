return {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'dark', -- other options: 'darker', 'cool', 'deep', 'warm', 'warmer
      transparent = true,
      term_colors = true,
      -- toggle theme style ---
      toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' }, -- List of styles to toggle between
    }

    require('onedark').load()
  end,
}
