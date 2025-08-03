return {
  {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    opts = {
      prompt = '> ',
    },
    keys = {
      {
        "<leader><leader>",
        function()
          require("fff").find_in_git_root()
        end,
        desc = "Search Files"
      },
            {
        "<leader>sf",
        function()
          require("fff").find_files()
        end,
        desc = "[S]earch [F]iles"
      },
    },
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
      { "<leader>sh",       "<cmd>Pick help<cr>",             desc = "[S]earch [H]elp" },
      { "<leader>sk",       "<cmd>Pick keymaps<cr>",          desc = "[S]earch [K]eymaps" },
      { "<leader>sf",       "<cmd>Pick files tool='git'<cr>", desc = "[S]earch Git [F]iles" },
      { "<leader><leader>", "<cmd>Pick files<cr>",            desc = "Search Files" },
      { "<leader>ss",       "<cmd>Pick lsp<cr>",              desc = "[S]earch [S]elect " },
      { "<leader>sw",       "<cmd>Pick grep<cr>",             desc = "[S]earch current [W]ord" },
      { "<leader>sm",       "<cmd>Pick marks<cr>",            desc = "[S]earch [M]arks" },
      { "<leader>sg",       "<cmd>Pick grep_live<cr>",        desc = "[S]earch by [G]rep" },
      { "<leader>sd",       "<cmd>Pick diagnostic<cr>",       desc = "[S]earch [D]iagnostics" },
      { "<leader>sR",       "<cmd>Pick resume<cr>",           desc = "[S]earch [R]esume" },
      { "<leader>s.",       "<cmd>Pick history<cr>",          desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader>sb",       "<cmd>Pick buffers<cr>",          desc = "[S]earch existing [B]uffers" },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {},
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    keys = {
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>",             desc = "[S]earch [A]utocmds" },
      { "<leader>sh", "<cmd>FzfLua help<cr>",                 desc = "[S]earch [H]elp" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>",              desc = "[S]earch [K]eymaps" },
      -- { "<leader>sf", "<cmd>FzfLua git_files",                desc = "[S]earch Git [F]iles" },
      -- { "<leader><leader>", "<cmd>FzfLua files<cr>",                desc = "Search Files" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "[S]earch [S]ymbols " },
      { "<leader>sw", "<cmd>FzfLua grep<cr>",                 desc = "[S]earch current [W]ord" },
      { "<leader>sw", "<cmd>FzfLua grep_visual<cr>",          desc = "[S]earch current [W]ord",               mode = { "x" } },
      { "<leader>sm", "<cmd>FzfLua marks<cr>",                desc = "[S]earch [M]arks" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>",            desc = "[S]earch by [G]rep" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "[S]earch [D]iagnostics" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>",               desc = "[S]earch [R]esume" },
      { "<leader>s.", "<cmd>FzfLua history<cr>",              desc = '[S]earch Recent Files ("." for repeat)' },
      { "<leader>sb", "<cmd>FzfLua buffers<cr>",              desc = "[S]earch existing [B]uffers" },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select()
    end,
  },
}
