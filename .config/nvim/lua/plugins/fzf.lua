local function dropdown(opts, ...)
  -- dd(I(opts))
  opts = opts or {}
  opts["winopts"] = opts.winopts or {}

  return vim.tbl_deep_extend("force", {
    prompt = opts.prompt,
    fzf_opts = { ["--layout"] = "reverse" },
    winopts = {
      title_pos = opts["winopts"].title and "center" or nil,
      height = 0.70,
      width = 0.55,
      row = 0.1,
      col = 0.5,
      preview = { hidden = "hidden", layout = "vertical", vertical = "up:50%" },
    },
  }, opts, ...)
end

local function cursor_dropdown(opts)
  return dropdown({
    winopts = {
      row = 1,
      relative = "cursor",
      height = 0.33,
      width = 0.25,
    },
  }, opts)
end

local function title(title, icon, opts)
  opts = opts or {}
  icon = icon or ""

  local path = opts.cwd or opts.path or nil
  local buf_path = vim.fn.expand("%:p:h")
  local cwd = vim.fn.getcwd()

  if title ~= nil then
    title = string.format("%s %s (%s)", icon, title, vim.fs.basename(path or vim.uv.cwd() or ""))
  else
    if path ~= nil and buf_path ~= cwd then
      title = require("plenary.path"):new(buf_path):make_relative(cwd)
    else
      title = vim.fn.fnamemodify(cwd, ":t")
    end
  end

  return title
end

return {
  "ibhagwan/fzf-lua",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  dependencies = {
    "elanmed/fzf-lua-frecency.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function(_, opts)
    local fzf = require("fzf-lua")
    local config = fzf.config
    local actions = fzf.actions
    require("fzf-lua-frecency").setup({
      cwd_only = true,
      display_score = false,
    })
    -- Quickfix
    config.defaults.keymap.fzf["ctrl-v"] = actions.file_vsplit
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
      fzf_bin = "sk",
      fzf_colors = true,
      fzf_opts = {
        ["--algo"] = "frizbee",
        ["--no-scrollbar"] = true,
        ["--layout"] = "reverse",
      },
      globals = {
        file_icons = "mini",
        cwd_prompt = false,
      },
      global = dropdown({
        winopts = { title = title("Search", "") },
        line_query = true,
      }),
      files = dropdown({
        cwd_prompt = false,
        multiprocess = true,
        line_query = true,
        winopts = { title = title("files", "") },
      }),
      buffers = dropdown({
        cwd_prompt = false,
        prompt = "",
        winopts = { title = title("buffers", "󰈙") },
        line_query = true,
      }),
      keymaps = dropdown({
        winopts = { title = title("keymaps", "") },
      }),
      registers = cursor_dropdown({
        winopts = { title = title("registers", ""), width = 0.6 },
      }),
      grep = dropdown({
        winopts = {
          title = title("grep", ""),
          preview = { hidden = false, layout = "vertical", vertical = "down:45%" },
        },
        -- Use --fixed-strings to interpret pattern as literal string, not regex
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --fixed-strings -e",
      }),
      git = {
        files = dropdown({
          cmd = "git ls-files --others --cached --exclude-standard",
          winopts = { title = title("git files", "") },
          line_query = true,
        }),
        branches = dropdown({
          winopts = { title = title("branches", ""), height = 0.3, row = 0.4 },
        }),
        status = {
          prompt = "",
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          winopts = { title = title("git status", "") },
        },
        bcommits = {
          prompt = "",
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          winopts = { title = title("buffer commits", "") },
        },
        commits = {
          prompt = "",
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
          winopts = { title = title("commits", "") },
        },
      },
      lsp = {
        workspace_symbols = dropdown({
          winopts = {
            title = title("workspace symbols", ""),
          },
        }),
        document_symbols = dropdown({
          winopts = {
            title = title("symbols", ""),
          },
        }),
        code_actions = cursor_dropdown({
          winopts = {
            title = title("code actions", "", "@type"),
          },
        }),
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
      { "<leader>sG", "<cmd>FzfLua live_grep_resume<cr>", desc = "[S]earch by [G]rep (literal)" },
      { "<leader>sg", function() require("fzf-lua").live_grep_resume({ rg_opts = "--column --line-number --no-heading --color=always --smart-case -e" }) end, desc = "[S]earch by [G]rep (regex)" },
      { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "[S]earch [H]elp" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "[S]earch [H]ighlights" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "[S]earch [J]umps" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "[S]earch [K]eymaps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "[S]earch [L]oclist" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "[S]earch [M]arks" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "[S]earch [M]an Pages" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "[S]earch [S]ymbols " },
      { "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "[S]earch [S]ymbols " },
      { "<leader>su", "<cmd>FzfLua undotree<cr>", desc = "[S]earch [U]ndotree " },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "[S]earch current [W]ord", mode = { "n", "v" }, },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>", desc = "[S]earch current [W]ord", mode = { "n", "v" }, },
      { "<leader>sv", "<cmd>FzfLua grep_visual<cr>", desc = "[S]earch [V]isual Selection", mode = { "n", "v" }, },
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "[S]earch [R]egisters" },
      { "<leader>s.", "<cmd>FzfLua resume<cr>", desc = '[S]earch [R]esume' },
      { "<leader>st", "<cmd>FzfLua colorschemes<cr>", desc = '[S]earch [T]hemes' },
      { "<leader><leader>", "<cmd>FzfLua combine pickers=buffers;frecency;lsp_live_workspace_symbols<cr>", desc = "Search files, buffers, buffer symbols, workspace symbols etc.", },
      { "<d-p>", "<cmd>FzfLua combine pickers=buffers;frecency;lsp_live_workspace_symbols<cr>", desc = "Search files, buffers, buffer symbols, workspace symbols etc.", },
      -- { "<d-p>", "<cmd>FzfLua global<cr>", desc = "Search files, buffers, buffer symbols, workspace symbols etc.", },
      { "<leader>s?", "<cmd>FzfLua builtin<cr>", desc = "[S]earch [B]uiltin Commands" },
      { "<leader>p", "<cmd>FzfLua registers<cr>", desc = "[P]aste from [R]egisters" },
    -- stylua: ignore end
  },
  config = function(_, opts)
    local fzf = require("fzf-lua")
    fzf.setup(opts)
    fzf.register_ui_select(dropdown({
      winopts = { title = title("select one of:"), height = 0.33, row = 0.5 },
    }))
  end,
}
