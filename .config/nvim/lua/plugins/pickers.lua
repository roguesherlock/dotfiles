return {
  {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    opts = {
      prompt = "> ",
      layout = {
        prompt_position = "top",
        width = 0.5,
        preview_position = "bottom",
      },
      debug = {
        enabled = false, -- we expect your collaboration at least during the beta
        show_scores = false, -- to help us optimize the scoring system, feel free to share your scores!
      },
      hl = {
        prompt = "Normal",
      },
      preview = {
        enabled = false,
      },
    },
    keys = {
      -- {
      --   "<leader><leader>",
      --   function()
      --     require("fff").find_in_git_root()
      --   end,
      --   desc = "Search Files",
      -- },
      -- {
      --   "<leader>sf",
      --   function()
      --     -- require("fff").find_in_git_root()
      --     require("fff").find_files()
      --   end,
      --   desc = "[S]earch [F]iles",
      -- },
    },
  },
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
    "ibhagwan/fzf-lua",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local config = fzf.config
      local actions = fzf.actions
      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
      -- Trouble
      -- config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

      return {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        global = {
          previewer = false,
          formatter = "path.filename_first",
          winopts = {
            width = 0.5,
          },
        },
        files = {
          previewer = false,
          formatter = "path.filename_first",
          winopts = {
            width = 0.5,
          },
        },
        git_files = {
          previewer = false,
          formatter = "path.filename_first",
          winopts = {
            width = 0.5,
          },
        },
        winopts = {
          preview = {
            horizontal = "right:40%",
            winopts = {
              number = false,
            },
          },
        },
        lsp = {
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          },
        },
      }
    end,
    keys = {
      -- stylua: ignore start
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "[S]earch [A]utocmds" },
      { "<leader>s/", "<cmd>FzfLua grep_curbuf<cr>", desc = "[S]earch in current [B]uffer" },
      { "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "[S]earch existing [b]uffers" },
      { "<leader>sB", "<cmd>FzfLua blines", desc = "[S]earch and Go to [B]uffer line" },
      { "<leader>sC", "<cmd>FzfLua command_history<cr>", desc = "[S]earch [C]ommand History" },
      { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "[S]earch [C]ommands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "[S]earch [d]iagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "[S]earch [D]iagnostics in workspace" },
      { "<leader>sf", "<cmd>FzfLua git_files<cr>", desc = "[S]earch Git [F]iles" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]earch by [G]rep" },
      { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "[S]earch [H]elp" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "[S]earch [H]ighlights" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "[S]earch [J]umps" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "[S]earch [K]eymaps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "[S]earch [L]oclist" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "[S]earch [M]arks" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "[S]earch [M]an Pages" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "[S]earch [S]ymbols " },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "[S]earch current [W]ord", mode = { "n", "v" }, },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>", desc = "[S]earch current [W]ord", mode = { "n", "v" }, },
      { "<leader>sv", "<cmd>FzfLua grep_visual<cr>", desc = "[S]earch [V]isual Selection", mode = { "n", "v" }, },
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "[S]earch [R]egisters" },
      { "<leader>s.", "<cmd>FzfLua resume<cr>", desc = '[S]earch [R]esume' },
      { "<leader>st", "<cmd>FzfLua colorschemes<cr>", desc = '[S]earch [T]hemes' },
      { "<leader><leader>", "<cmd>FzfLua global<cr>", desc = "Search files, buffers, buffer symbols, workspace symbols etc.", },
      { "<d-p>", "<cmd>FzfLua global<cr>", desc = "Search files, buffers, buffer symbols, workspace symbols etc.", },
      { "<leader>s?", "<cmd>FzfLua builtin<cr>", desc = "[S]earch [B]uiltin Commands" },
      -- stylua: ignore end
    },
    config = function(_, opts)
      local fzf = require("fzf-lua")
      local file_picker = require("fff.file_picker")
      local make_entry = require("fzf-lua.make_entry")
      if not file_picker.is_initialized() then
        local setup_success = file_picker.setup()
        if not setup_success then
          vim.notify("Failed to initialize file picker", vim.log.levels.ERROR)
        end
      end
      -- local state = {}
      fzf.setup(opts)
      fzf.register_ui_select()
      local map = require("user.util").map

      local function frecency()
        local live_opts = {
          exec_empty_query = true,
          winopts = {
            width = 0.5,
          },
          actions = fzf.defaults.actions.files,
          fn_transform = function(s)
            print(s)
            return s
          end,
          formatter = "path.filename_first",
          -- formatter = fzf.defaults.formatters.path.filename_first,
        }
        fzf.fzf_live(function(args)
          local q = args[1]

          return function(fzf_cb)
            local files = file_picker.search_files(q, 100, 4, nil, false)
            for _, file in ipairs(files) do
              fzf_cb(file.path)
              -- fzf_cb(make_entry.file(file.path, { file_icons = true, color_icons = true }))
            end
            -- signal EOF to close the named pipe
            -- and stop fzf's loading indicator
            fzf_cb()
          end

          -- return coroutine.wrap(function(fzf_cb)
          --   local co = coroutine.running()
          --   -- if not state.current_file_cache then
          --   --   local current_buf = vim.api.nvim_get_current_buf()
          --   --   if current_buf and vim.api.nvim_buf_is_valid(current_buf) then
          --   --     local current_file = vim.api.nvim_buf_get_name(current_buf)
          --   --     if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
          --   --       state.current_file_cache = current_file
          --   --     else
          --   --       state.current_file_cache = nil
          --   --     end
          --   --   end
          --   -- end
          --   local files = file_picker.search_files(q, 100, 4, nil, false)
          --   for _, file in ipairs(files) do
          --     fzf_cb(file.path, function()
          --       coroutine.resume(co)
          --     end)
          --     coroutine.yield()
          --   end
          --   -- signal EOF to close the named pipe
          --   -- and stop fzf's loading indicator
          --   fzf_cb()
          -- end)
        end, live_opts)
      end

      -- map("n", "<leader><leader>", frecency, { desc = "Search files" })
      -- map("n", "<d-p>", frecency, { desc = "Search files" })
    end,
  },
}
