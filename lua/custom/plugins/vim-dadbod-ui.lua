
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.api.nvim_create_autocmd({'FileType'}, {
      pattern = "dbout",
      callback = function()
        vim.opt_local.foldlevel = 99
      end
    })
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
