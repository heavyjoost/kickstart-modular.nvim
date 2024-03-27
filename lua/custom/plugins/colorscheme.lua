return {
  { 'folke/tokyonight.nvim', enable = false },
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        palette_overrides = {
          dark0_hard = "#000000",
        },
        overrides = {
          TelescopeSelection = {
            -- link = "GruvboxOrangeBold",
            fg = "#fe8019",
            bold = true,
            bg = "#332e2a",
          },
        },
      })
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  -- 'iagorrr/noctishc.nvim',
  -- 'tomasiser/vim-code-dark',
  -- {
  --   'bluz71/vim-moonfly-colors',
  --   name = "moonfly",
  -- },
  -- {
  --   'Mofiqul/vscode.nvim',
  --   opts = {
  --     -- Higher contrast
  --     color_overrides = {
  --       vscFront = '#FFFFFF',
  --       vscBack = '#000000',
  --       vscPopupFront = '#FFFFFF',
  --       vscContext = '#FFFFFF',
  --       vscContextCurrent = '#FFFFFF',
  --     }
  --   }
  -- },
  -- {
  --   "rockyzhang24/arctic.nvim",
  --   branch = "v2",
  --   dependencies = { "rktjmp/lush.nvim" },
  --   config = function()
  --     -- vim.cmd.colorscheme 'my-arctic'
  --   end,
  -- },
}
