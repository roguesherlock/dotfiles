return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "tailwindcss",
            "lua_ls",
            "stylua",
            "prismals",
            "prettier",
            "vtsls",
            "phpactor"
          },

        }
      },
      "neovim/nvim-lspconfig",
    },
  },
}
