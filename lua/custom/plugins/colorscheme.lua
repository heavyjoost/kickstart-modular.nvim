return {
  'iagorrr/noctishc.nvim',
  'tomasiser/vim-code-dark',
  {
    'bluz71/vim-moonfly-colors',
    name = "moonfly",
  },
  {
    'Mofiqul/vscode.nvim',
    opts = {
      -- Higher contrast
      color_overrides = {
        vscFront = '#FFFFFF',
        vscBack = '#000000',
        vscPopupFront = '#FFFFFF',
        vscContext = '#FFFFFF',
        vscContextCurrent = '#FFFFFF',
      }
    }
  },
  {
    "rockyzhang24/arctic.nvim",
    branch = "v2",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd.colorscheme 'my-arctic'
    end,
  },
}
