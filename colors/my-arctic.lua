vim.opt.background = 'dark'
vim.g.colors_name = 'my-arctic'

-- First we will need lush, and the colorscheme we wish to modify
local lush = require 'lush'
local arctic = require 'lush_theme.arctic'

local norm_bg = '#000000'

-- we can apply modifications ontop of the existing colorscheme
local spec = lush.extends({ arctic }).with(function()
  return {
    Cursor { fg = arctic.Cursor.fg, bg = norm_bg, gui = arctic.Cursor.gui },
    Normal { fg = arctic.Normal.fg, bg = norm_bg, gui = arctic.Normal.gui },
    Todo { fg = norm_bg, bg = arctic.Todo.fg, gui = arctic.Todo.gui },
    UnnecessaryCode { fg = '#6892a9', bg = arctic.UnnecessaryCode.fg, gui = arctic.UnnecessaryCode.gui },
  }
end)

-- then pass the extended spec to lush for application
lush(spec)
