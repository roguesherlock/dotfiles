return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "tailwindcss",
        "lua_ls",
        "stylua",
        "prismals",
        "prettier",
        "vtsls",
        "phpactor",
        "vue-language-server",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
      "neovim/nvim-lspconfig",
    },
  },
}
