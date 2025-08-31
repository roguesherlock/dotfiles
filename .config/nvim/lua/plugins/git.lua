return {
  -- Gitsigns for git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Jump to next git [c]hange" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Jump to previous git [c]hange" })

        -- Actions
        -- visual mode
        -- stylua: ignore start
        map("v", "<leader>ghs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[G]it [H]unk [S]tage " })
        map("v", "<leader>ghr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "[G]it [H]unk [R]eset " })
        -- normal mode
        map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "[G]it [H]unk [S]tage" })
        map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "[G]it [H]unk [R]eset" })
        map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[G]it [S]tage buffer" })
        map("n", "<leader>ghu", gitsigns.undo_stage_hunk, { desc = "[G]it [H]unk [U]ndo stage" })
        map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[G]it [R]eset buffer" })
        map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "[G]it [H]unk [p]review" })
        map("n", "<leader>gb", gitsigns.blame_line, { desc = "[G]it [B]lame line" })
        map("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [D]iff against index" })
        map("n", "<leader>gD", function() gitsigns.diffthis("@") end, { desc = "[G]it [D]iff against last commit" })
        -- Toggles
        map("n", "<leader>tgb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle [G]it show [B]lame line" })
        map("n", "<leader>tgD", gitsigns.toggle_deleted, { desc = "[T]oggle [G]it show [D]eleted" })
        -- stylua: ignore end
      end,
    },
  },
  -- Neogit for git interface
  {
    "NeogitOrg/neogit",
    enabled = true,
    dependencies = {
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    event = "VeryLazy",
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true,
        },
        graph_style = "kitty",
      })

      local map = require("user.util").map
      map("n", "<leader>gn", "<cmd>Neogit<cr>", { desc = "[G]it Open [N]eogit" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gdf", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it [D]iff [F]ile" },
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iffview [O]pen" },
    },
    opts = {
      keymaps = {
        view = {
          -- stylua: ignore
          { "n", "q", function() require("diffview.actions").close() end, { desc = "Close" }, },
        },
        file_panel = {
          -- stylua: ignore
          { "n", "q", function() require("diffview.actions").close() end, { desc = "Close" }, },
        },
        file_history_panel = {
          -- stylua: ignore
          { "n", "q", function() require("diffview.actions").close() end, { desc = "Close" }, },
        },
      },
    },
  },
}
