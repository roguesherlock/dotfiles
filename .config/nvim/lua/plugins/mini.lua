return {
  {
    "nvim-mini/mini.pick",
    enabled = false,
    opts = {
      mappings = {
        to_quickfix = {
          char = "<c-q>",
          func = function()
            local items = MiniPick.get_picker_items() or {}
            MiniPick.default_choose_marked(items)
            MiniPick.stop()
          end,
        },
      },
    },
    keys = {
      { "<leader>sh", "<cmd>Pick help<cr>", desc = "[S]earch [H]elp" },
      { "<leader>sk", "<cmd>Pick keymaps<cr>", desc = "[S]earch [K]eymaps" },
      { "<leader>sf", "<cmd>Pick files tool='git'<cr>", desc = "[S]earch Git [F]iles" },
      { "<leader><leader>", "<cmd>Pick files<cr>", desc = "Search Files" },
      { "<leader>ss", "<cmd>Pick lsp<cr>", desc = "[S]earch [S]elect " },
      { "<leader>sw", "<cmd>Pick grep<cr>", desc = "[S]earch current [W]ord" },
      { "<leader>sm", "<cmd>Pick marks<cr>", desc = "[S]earch [M]arks" },
      { "<leader>sg", "<cmd>Pick grep_live<cr>", desc = "[S]earch by [G]rep" },
      { "<leader>sd", "<cmd>Pick diagnostic<cr>", desc = "[S]earch [D]iagnostics" },
      { "<leader>sR", "<cmd>Pick resume<cr>", desc = "[S]earch [R]esume" },
      { "<leader>s.", "<cmd>Pick history<cr>", desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader>sb", "<cmd>Pick buffers<cr>", desc = "[S]earch existing [B]uffers" },
    },
  },
  {
    "nvim-mini/mini.hipatterns",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          -- fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          -- hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          -- todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          -- note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "nvim-mini/mini.files",
    keys = {
      {
        "<leader>e",
        function()
          local MiniFiles = require("mini.files")
          if not MiniFiles.close() then
            local is_buffer_a_file = (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "")
            if is_buffer_a_file then
              MiniFiles.open(vim.api.nvim_buf_get_name(0))
            else
              MiniFiles.open()
            end
          end
        end,
        desc = "Toggle file [E]xplorer",
      },
    },
    opts = {
      mappings = {
        go_in_plus = "<cr>",
        synchronize = "=",
      },
      windows = {
        preview = true,
        width_preview = 60,
      },
    },
    setup = function(_, opts)
      local files = require("mini.files")
      files.setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        description = "Notify lsp when renaming file",
        group = vim.api.nvim_create_augroup("user-mini-files-rename", { clear = true }),
        callback = function(event)
          local ok, snacks = pcall(require, "snacks.nvim")
          if not ok then
            return
          end
          snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  },
  { "nvim-mini/mini.bracketed", opts = {
    window = { suffix = "W", options = {} },
  } },
  { "nvim-mini/mini.splitjoin" },
  { "nvim-mini/mini.extra" },
  { "nvim-mini/mini.icons" },
  { "nvim-mini/mini.comment" },
  { "nvim-mini/mini.ai" },
  { "nvim-mini/mini.pairs", enabled = false },
  {
    "nvim-mini/mini.statusline",
    enabled = false,
    config = function()
      local statusline = require("mini.statusline")
      local icons = require("mini.icons")

      -- Cache for the recorder module
      local recorder_cache = {
        exists = nil,
        module = nil,
      }
      local function get_recorder()
        if recorder_cache.exists == nil then
          recorder_cache.exists, recorder_cache.module = pcall(require, "recorder")
        end
        return recorder_cache.exists, recorder_cache.module
      end

      local recorder_status = function()
        local recorder_exists, recorder = get_recorder()
        if recorder_exists and recorder then
          return recorder.recordingStatus()
        end
        return ""
      end

      statusline.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local branch = statusline.section_git({ trunc_width = 40 })
            local diagnostics = statusline.section_diagnostics({ trunc_width = 40 })
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
            local search = statusline.section_searchcount({ trunc_width = 75 })
            local recorder = recorder_status()

            return statusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { branch } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = mode_hl, strings = { recorder, search, diagnostics } },
            })
          end,
        },
      })
    end,
  },
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    },
  },
  {
    "nvim-mini/mini.starter",
    enabled = false,
    config = function()
      local starter = require("mini.starter")
      local pad = string.rep(" ", 22)
      starter.setup({
        evaluate_single = true,
        items = {
          starter.sections.builtin_actions(),
          {
            name = "Find files",
            action = function()
              local bufnr = vim.api.nvim_get_current_buf()
              starter.close(bufnr)
              require("fff").find_files()
            end,
            section = "Builtin actions",
          },
          {
            name = "Grep live",
            action = "FzfLua live_grep",
            section = "Builtin actions",
          },
          {
            name = "Restore session",
            action = [[lua require("persistence").load()]],
            section = "Sessions",
          },
          starter.sections.recent_files(5, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.indexing("all", { "Builtin actions", "Sessions" }),
          starter.gen_hook.aligning("center", "center"),
        },
      })
    end,
  },
}
