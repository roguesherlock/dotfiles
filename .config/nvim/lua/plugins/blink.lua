return {
  {
    "saghen/blink.indent",
    enabled = false,
    opts = {
      static = {
        enabled = false,
      },
      scope = {
        highlights = { "BlinkIndent" },
      },
    },
  },
  {
    "saghen/blink.pairs",
    build = "cargo build --release",
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      highlights = {
        enabled = false,
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- "fang2hou/blink-copilot",
    },
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "default",
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = {
          "snippet_forward",
          function() -- sidekick next edit suggestion
            return require("sidekick").nes_jump_or_apply()
          end,
          function() -- if you are using Neovim's native inline completions
            return vim.lsp.inline_completion.get()
          end,
          "fallback",
        },
      },
      completion = {
        ghost_text = { enabled = false },
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
        menu = { draw = { treesitter = { "lsp" } } },
      },
      signature = { enabled = true },
      fuzzy = {
        -- exact matches always take precedence
        sorts = {
          "exact",
          -- defaults
          "score",
          "sort_text",
        },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          -- recommended, as the default keymap will only show and select the next item
          ["<Tab>"] = { "show", "accept" },
        },
        completion = {
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
              -- enable for inputs as well, with:
              -- or vim.fn.getcmdtype() == '@'
            end,
          },
        },
      },
      sources = {
        -- default = { "copilot", "lsp", "snippets", "buffer" },
        default = { "lsp", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 80,
          },
          -- copilot = {
          --   name = "copilot",
          --   module = "blink-copilot",
          --   score_offset = 100,
          --   async = true,
          -- },
        },
      },
    },
  },
}
