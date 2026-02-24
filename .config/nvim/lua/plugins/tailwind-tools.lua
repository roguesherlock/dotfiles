return {
  -- tailwind-tools.lua
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  -- enabled = false,
  opts = {
    server = {
      -- We already configure tailwindcss via `vim.lsp.config` in core/lsp.lua.
      -- Disabling the plugin override avoids deprecated `require("lspconfig")` usage.
      override = false,
    },
  },
}
