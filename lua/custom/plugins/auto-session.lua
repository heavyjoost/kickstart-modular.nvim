vim.keymap.set('n', '<leader>sp', ':Telescope session-lens<cr>', { desc = '[S]earch [P]roject session' })

return {
  'rmagatti/auto-session',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    suppressed_dirs = { '~/', '~/Downloads', '/' },
  },
}
