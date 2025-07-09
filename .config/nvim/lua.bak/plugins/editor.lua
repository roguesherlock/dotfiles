return {
  -- Trouble for diagnostics
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup({})
      local map = require("config.keymaps").map
      map("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle trouble diagnostics" })
      map("n", "<leader>q", "<cmd>Trouble qflist toggle<cr>", { desc = "Toggle trouble [Q]uickfix" })
    end,
  },

  -- Noice for better UI
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        notify = {
          enabled = false,
        },
        lsp = {
          hover = {
            silent = true,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        views = {
          mini = {
            win_options = {
              winblend = 0,
            },
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,
  },

  -- Grug-far for search and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      local g = require("grug-far")
      g.setup({})

      local map = require("config.keymaps").map
      map("n", "<leader>sr", function()
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        g.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end, {
        desc = "[S]earch and [R]eplace",
      })
      map("v", "<leader>sr", function()
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        g.with_visual_selection({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end, {
        desc = "[S]earch and [R]eplace with selection as input",
      })
    end,
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup({
        signs = false,
      })
      local map = require("config.keymaps").map
      map("n", "]t", function()
        require("todo-comments").jump_next({ "FIX", "TODO" })
      end, { desc = "Next todo comment" })

      map("n", "[t", function()
        require("todo-comments").jump_prev({ "FIX", "TODO" })
      end, { desc = "Previous todo comment" })

      map("n", "<leader>xt", "<cmd>TodoQuickFix<cr>", { desc = "Open Todo" })
    end,
  },

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
        settings = {
          save_on_toggle = true,
        },
      })

      local map = require("config.keymaps").map
      map("n", "<leader>H", function()
        require("harpoon"):list():add()
      end, { desc = "Add Harpoon File" })

      map("n", "<leader>tp", function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "[T]oggle Har[P]oon Quick Menu" })

      for i = 1, 5 do
        map("n", "<leader>" .. i, function()
          require("harpoon"):list():select(i)
        end, { desc = "Harpoon to File " .. i })
      end
    end,
  },

  -- Zen mode for distraction-free writing
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    cmd = "ZenMode",
    config = function()
      local map = require("config.keymaps").map
      map("n", "<leader>z", ":ZenMode<cr>", { desc = "Toggle [Z]en mode" })
    end,
  },

  -- Nvim recorder for macros
  {
    "chrisgrieser/nvim-recorder",
    config = function()
      require("recorder").setup({
        mapping = {
          startStopRecording = "q",
          playMacro = "Q",
        },
      })
    end,
  },

  -- Snipe for buffer navigation
  {
    "leath-dub/snipe.nvim",
    keys = { "gb" },
    config = function()
      require("snipe").setup({
        ui = {
          position = "center",
        },
        hints = {
          -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
          dictionary = "sadflewvrcmnpghioty",
        },
        navigate = {
          next_page = "<c-n>",
          prev_page = "<c-p>",
          close_buffer = "<c-d>",
          open_vsplit = "<c-v>",
          open_hsplit = "<c-h>",
          cancel_snipe = "q",
        },
      })

      local map = require("config.keymaps").map
      map("n", "gb", function()
        require("snipe").open_buffer_menu()
      end, { desc = "Open Snipe buffer menu" })
    end,
  },

  -- Leap for fast navigation
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_mappings()
    end,
  },

  -- UFO for better folding
  {
    "kevinhwang91/nvim-ufo",
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

      local map = require("config.keymaps").map
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
  {
    "echasnovski/mini.files",
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
  { "echasnovski/mini.bracketed", opts = {
    window = { suffix = "W", options = {} },
  } },
  { "echasnovski/mini.extra" },
  { "echasnovski/mini.icons" },
  {
    "echasnovski/mini.statusline",
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
    "echasnovski/mini.pick",
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
      { "<leader>sh", "<cmd>Pick help<cr>", { desc = "[S]earch [H]elp" } },
      { "<leader>sk", "<cmd>Pick keymaps<cr>", { desc = "[S]earch [K]eymaps" } },
      { "<leader>sf", "<cmd>Pick files tool='git'<cr>", { desc = "[S]earch Git [F]iles" } },
      { "<leader><leader>", "<cmd>Pick files<cr>", { desc = "Search Files" } },
      { "<leader>ss", "<cmd>Pick lsp<cr>", { desc = "[S]earch [S]elect " } },
      { "<leader>sw", "<cmd>Pick grep<cr>", { desc = "[S]earch current [W]ord" } },
      { "<leader>sm", "<cmd>Pick marks<cr>", { desc = "[S]earch [M]arks" } },
      { "<leader>sg", "<cmd>Pick grep_live<cr>", { desc = "[S]earch by [G]rep" } },
      { "<leader>sd", "<cmd>Pick diagnostic<cr>", { desc = "[S]earch [D]iagnostics" } },
      { "<leader>sR", "<cmd>Pick resume<cr>", { desc = "[S]earch [R]esume" } },
      { "<leader>s.", "<cmd>Pick history<cr>", { desc = '[S]earch Recent Files ("." for repeat)' } },
      { "<leader>sb", "<cmd>Pick buffers<cr>", { desc = "[S]earch existing [B]uffers" } },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {},
    keys = {
      { "<leader>sh", "<cmd>FzfLua help<cr>", { desc = "[S]earch [H]elp" } },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "[S]earch [K]eymaps" } },
      { "<leader>sf", "<cmd>FzfLua git_files", { desc = "[S]earch Git [F]iles" } },
      { "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Search Files" } },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "[S]earch [S]ymbols " } },
      { "<leader>sw", "<cmd>FzfLua grep<cr>", { desc = "[S]earch current [W]ord" } },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "[S]earch [M]arks" } },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "[S]earch by [G]rep" } },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "[S]earch [D]iagnostics" } },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "[S]earch [R]esume" } },
      { "<leader>s.", "<cmd>FzfLua history<cr>", { desc = '[S]earch Recent Files ("." for repeat)' } },
      { "<leader>sb", "<cmd>FzfLua buffers<cr>", { desc = "[S]earch existing [B]uffers" } },
    },
  },
  {
    "echasnovski/mini.surround",
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
