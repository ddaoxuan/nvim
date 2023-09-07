return {
  'nvim-lualine/lualine.nvim', -- Set lualine as statusline
  -- See `:help lualine.txt`
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status' -- to configure lazy status updates

    lualine.setup {
      options = {
        theme = 'onedark',
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },
      },
    }
  end,
}
