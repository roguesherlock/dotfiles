-- Cute code action floating window.
return {
  {
    "rachartier/tiny-code-action.nvim",
    event = "LspAttach",
    opts = {
      backend = "delta",
      picker = {
        "buffer",
        opts = {
          hotkeys = true,
          auto_preview = false, -- Enable or disable automatic preview

          -- Use numeric labels.
          -- hotkeys_mode = function(titles)
          --   return vim
          --     .iter(ipairs(titles))
          --     :map(function(i)
          --       return tostring(i)
          --     end)
          --     :totable()
          -- end,
        },
      },
    },
  },
}
