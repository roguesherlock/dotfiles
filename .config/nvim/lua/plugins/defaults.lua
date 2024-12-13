return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        diagnostics = {
          Error = "●",
          Warn = "●",
          Hint = "●",
          Info = "●",
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        enabled = false,
      },
      indent = {
        enabled = false,
        only_scope = true,
      },
    },
  },
}
