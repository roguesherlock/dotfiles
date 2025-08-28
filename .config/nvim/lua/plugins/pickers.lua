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
      preview = {
        enabled = false,
      },
    },
    keys = {
      {
        "<leader><leader>",
        function()
          require("fff").find_in_git_root()
        end,
        desc = "Search Files",
      },
      {
        "<leader>sf",
        function()
          -- require("fff").find_in_git_root()
          require("fff").find_files()
        end,
        desc = "[S]earch [F]iles",
      },
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
      config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

      return {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        files = { formatter = "path.filename_first" },
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
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "[S]earch in current [b]uffer" },
      { "<leader>sB", "<cmd>FzfLua buffers<cr>", desc = "[S]earch existing [B]uffers" },
      { "<leader>sC", "<cmd>FzfLua command_history<cr>", desc = "[S]earch [C]ommand History" },
      { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "[S]earch [C]ommands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "[S]earch [d]iagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "[S]earch [D]iagnostics in workspace" },
      -- { "<leader>sf", "<cmd>FzfLua git_files<cr>",                desc = "[S]earch Git [F]iles" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]earch by [G]rep" },
      { "<leader>sh", "<cmd>FzfLua help<cr>", desc = "[S]earch [H]elp" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "[S]earch [H]ighlights" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "[S]earch [J]umps" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "[S]earch [K]eymaps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "[S]earch [L]oclist" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "[S]earch [M]arks" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "[S]earch [M]an Pages" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "[S]earch [R]esume" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "[S]earch [S]ymbols " },
      { "<leader>sw", "<cmd>FzfLua grep<cr>", desc = "[S]earch current [W]ord" },
      { "<leader>sw", "<cmd>FzfLua grep_visual<cr>", desc = "[S]earch current [W]ord", mode = { "x" }, },
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "[S]earch [R]egisters" },
      { "<leader>s.", "<cmd>FzfLua history<cr>", desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader>st", "<cmd>FzfLua colorschemes<cr>", desc = '[S]earch [T]hemes' },
      -- { "<leader><leader>", "<cmd>FzfLua global<cr>", desc = "Search files, buffers, buffer symbols, workspace symbols etc.", },
      -- stylua: ignore end
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select()
    end,
  },
}
