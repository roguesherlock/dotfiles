return {
  -- UFO for better folding
  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ufo = require("ufo")

      vim.opt.foldcolumn = "0" -- '0' is not bad
      vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      ufo.setup({
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" },
          json = { "array" },
          c = { "comment", "region" },
        },
        open_fold_hl_timeout = 0,
        provider_selector = function(_, filetype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
          local _start = lnum - 1
          local _end = end_lnum - 1
          local start_text = vim.api.nvim_buf_get_text(0, _start, 0, _start, -1, {})[1]
          local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
          return start_text .. " ⋯ " .. final_text .. (" 󰁂 %d "):format(end_lnum - lnum)
        end,
      })

      local map = require("user.util").map
      map("n", "zR", require("ufo").openAllFolds)
      map("n", "zM", require("ufo").closeAllFolds)
      map("n", "zr", require("ufo").openFoldsExceptKinds)
      map("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      map("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end)
    end,
  },
}
