return {
  {
    "saghen/blink.indent",
    enabled = true,
    opts = {
      static = {
        enabled = false,
        char = "│",
      },
      scope = {
        char = "│",
        highlights = { "BlinkIndent" },
      },
    },
  },
  {
    "saghen/blink.pairs",
    version = "v0.6.0",
    dependencies = "saghen/blink.lib",
    build = function(plugin)
      local native = require("blink.lib.native")
      local platform = native.platform()
      assert(platform.triple ~= nil, "Unsupported platform for blink.pairs native library")

      local commit = native.try_git_commit(plugin.dir)
      assert(commit ~= nil, "Could not determine blink.pairs git commit")

      local library_path = native.library_path(plugin.dir, "blink_pairs_parser", commit)
      local download_url = ("https://github.com/saghen/blink.pairs/releases/download/v0.6.0/%s%s"):format(
        platform.triple,
        platform.lib_extension
      )

      local result = vim.system({ "curl", "-fL", "--create-dirs", "-o", library_path, download_url }):wait(60000)
      assert(result.code == 0, result.stderr)
      assert(native.resolve("blink_pairs_parser", commit) ~= nil, "Failed to load downloaded blink.pairs library")
    end,
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        cmdline = false,
      },
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
