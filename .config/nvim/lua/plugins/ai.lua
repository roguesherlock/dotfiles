return {
  -- { "augmentcode/augment.vim" },
  -- Sidekick
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "zellij",
          enabled = false,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        desc = "Sidekick Switch Focus",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ focus = true })
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Claude Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle({ name = "grok", focus = true })
        end,
        desc = "Sidekick Grok Toggle",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },

  -- Supermaven AI completion
  {
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    event = { "InsertEnter", "VeryLazy" },
    config = function()
      require("supermaven-nvim").setup({ log_level = "off" })
      local map = require("user.util").map
      -- Trigger completion with <tab> manually since mini.completion doesn't play well with supermaven
      map("i", "<tab>", function()
        local suggestion = require("supermaven-nvim.completion_preview")
        if suggestion.has_suggestion() then
          suggestion.on_accept_suggestion()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<tab>", true, false, true), "n", true)
        end
      end, { desc = "Accept Supermaven suggestion" })
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = { "InsertEnter", "VeryLazy" },
    dependencies = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    opts = {
      panel = {
        enabled = false,
        auto_refresh = false,
      },
      suggestion = {
        enabled = false,
      },
      filetypes = {
        markdown = true,
        help = true,
      },
      nes = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_and_goto = "<tab>",
          accept = false,
          dismiss = "<Esc>",
        },
      },
    },
  },

  -- CodeCompanion AI chat
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "ravitemer/mcphub.nvim",
    },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      local map = require("user.util").map
      map({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "[A]i Actions [P]rompt" })
      map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle [A]i Chat" })
      map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", { desc = "[A]i add to [C]hat" })
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },

  -- Magenta AI
  {
    "dlants/magenta.nvim",
    enabled = false,
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
    -- stylua: ignore
    keys = {
      { "<leader>aa", "<cmd>Magenta toggle<cr>",                                         mode = { "n" }, desc = "Toggle [A]i chat" },
      { "<leader>an", "<cmd>Magenta new-thread<cr>",                                     mode = { "n" }, desc = "[A]i [N]ew thread" },
      { "<leader>as", "<cmd>Magenta abort<cr>",                                          mode = { "n" }, desc = " [A]i [S]top current operation" },
      { "<leader>ac", "<cmd>Magenta clear<cr>",                                          mode = { "n" }, desc = "[A]i [C]lear state" },
      { "<leader>ae", "<cmd>Magenta start-inline-edit<cr>",                              mode = { "n" }, desc = "[A]i [E]dit inline" },
      { "<leader>ae", "<cmd>Magenta start-inline-edit-selection<cr>",                    mode = { "v" }, desc = "[A]i [E]dit inline" },
      { "<leader>ar", "<cmd>Magenta replay-inline-edit<cr>",                             mode = { "n" }, desc = "[A]i [R]eplay last inline edit" },
      { "<leader>ar", "<cmd>Magenta replay-inline-edit-selection<cr>",                   mode = { "v" }, desc = "[A]i [R]eplay last inline edit on selection", },
      { "<leader>a.", "<cmd>Magenta replay-inline-edit<cr>",                             mode = { "n" }, desc = "[A]i [R]eplay last inline edit" },
      { "<leader>a.", "<cmd>Magenta replay-inline-edit-selection<cr>",                   mode = { "v" }, desc = "[A]i [R]eplay last inline edit on selection", },
      { "<leader>ab", "<cmd>Magenta paste-selection<cr>",                                mode = { "v" }, desc = "Add selection to [A]i [C]hat buffer", },
      { "<leader>ab", function() require("magenta.actions").add_buffer_to_context() end, mode = { "n" }, desc = "[A]i add [B]uffer to chat", },
      { "<leader>ab", "<cmd>Magenta paste-selection<cr>",                                mode = { "v" }, desc = "Add selection to [A]i [C]hat buffer", },
      { "<leader>ab", function() require("magenta.actions").add_buffer_to_context() end, mode = { "n" }, desc = "[A]i add [B]uffer to chat", },
      { "<leader>af", function() require("magenta.actions").pick_context_files() end,    mode = { "n" }, desc = "[A]i add [F]iles to chat", },
      { "<leader>ap", function() require("magenta.actions").pick_provider() end,         mode = { "n" }, desc = "[A]i pick [P]rovider", },
    },
    opts = {
      default_keymaps = false,
      sidebarPosition = "right",
      sidebarKeymaps = {
        normal = {
          ["<CR>"] = ":Magenta send<CR>",
          ["q"] = ":Magenta toggle<CR>",
        },
      },
      displayKeymaps = {
        normal = {
          ["-"] = ":Magenta threads-overview<CR>",
          ["q"] = ":Magenta toggle<CR>",
        },
      },
      inlineKeymaps = {
        -- stylua: ignore
        normal = {
          ["<CR>"] = function(target_bufnr) vim.cmd("Magenta submit-inline-edit " .. target_bufnr) end,
          ["q"] = function(target_bufnr) pcall(vim.api.nvim_buf_delete, target_bufnr, { force = true }) end,
        },
        autoContext = {
          "context.md",
          "claude.md",
          "agent.md",
          "agents.md",
          ".cursor/rules",
          ".magenta/*.md",
        },
      },
    },
  },

  -- opencode integration
  {
    "NickvanDyke/opencode.nvim",
    enabled = false,
    opts = {
      auto_reload = true, -- Automatically reload buffers edited by opencode
      auto_focus = true, -- Focus the opencode window after prompting
    },
    -- stylua: ignore
    keys = {
      -- opencode.nvim exposes a general, flexible API — customize it to your workflow!
      -- But here are some examples to get you started :)
      { '<leader>at', function() require('opencode').toggle() end,                                                      desc = '[A]i [T]oggle opencode', },
      { '<leader>aa', function() require('opencode').ask('@cursor: ') end,                                              desc = '[A] [a]sk opencode',                     mode = { 'n' }, },
      { '<leader>aa', function() require('opencode').ask('@selection: ') end,                                           desc = '[A] [a]sk opencode',                     mode = { 'v' }, },
      { '<leader>aA', function() require('opencode').ask('@buffer ') end,                                               desc = '[A]i [A]sk opencode about current buffer', mode = { 'n', 'v' }, },
      { '<leader>an', function() require('opencode').command('/new') end,                                               desc = '[A]i [N]ew session', },
      { '<leader>ae', function() require('opencode').prompt('Explain @cursor and its context') end,                     desc = '[A]i [E]xplain code near cursor' },
      { '<leader>ar', function() require('opencode').prompt('Review @buffer for correctness and readability') end,      desc = '[A]i [R]eview file', },
      { '<leader>af', function() require('opencode').prompt('Fix this @diagnostic') end,                                desc = '[A]i [f]ix error on current line', },
      { '<leader>aF', function() require('opencode').prompt('Fix these @diagnostics') end,                              desc = '[A]i [F]ix all errors in current buffer', },
      { '<leader>ao', function() require('opencode').prompt('Optimize @selection for performance and readability') end, desc = '[A]i [O]ptimize selection',              mode = 'v', },
      { '<leader>ad', function() require('opencode').prompt('Add documentation comments for @selection') end,           desc = '[A]i [D]ocument selection',              mode = 'v', },
    },
    config = function(_, opts)
      require("opencode").setup(opts)

      -- Listen for opencode events
      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent",
        callback = function(args)
          -- See the available event types and their properties
          -- vim.notify(vim.inspect(args.data), vim.log.levels.DEBUG)
          -- Do something interesting, like show a notification when opencode finishes responding
          if args.data.type == "session.idle" then
            vim.notify("opencode finished responding", vim.log.levels.INFO)
          end
        end,
      })
    end,
  },
}
