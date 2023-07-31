return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim"
  },
    { 'rose-pine/neovim', name = 'rose-pine' },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox"
      -- colorscheme = "catppuccin"
      colorscheme = "rose-pine"
    }
  }
}
