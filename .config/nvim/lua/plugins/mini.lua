return {
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
  },
  { "nvim-mini/mini.bracketed", opts = {
    window = { suffix = "W", options = {} },
  } },
  { "nvim-mini/mini.extra" },
  { "nvim-mini/mini.icons" },
  {
    "nvim-mini/mini.statusline",
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
}
