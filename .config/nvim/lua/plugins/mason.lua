return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- TODO: this isn't working for some reason. mason thinks these are invalid, more specifically for stylua, prettier and vue-language-server.
        -- "tailwindcss",
        -- "lua_ls",
        -- "stylua",
        -- "prismals",
        -- "prettier",
        -- "vtsls",
        -- "phpactor",
        -- "vue-language-server",
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
