return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  opts = {
    signs = false,
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*]],
      keyword = 'bg',
    },
  },
}
