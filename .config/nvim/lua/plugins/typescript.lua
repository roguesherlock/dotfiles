return {
  {
    "dmmulroy/ts-error-translator.nvim",
    opts = {
      auto_attach = true,
    },
  },
  {
    "marilari88/twoslash-queries.nvim",
    event = "VeryLazy",
    config = function()
      require("twoslash-queries").setup({
        multi_line = true,
        is_enabled = false,
        highlight = "Comment",
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "marilari88/twoslash-queries.nvim",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client, buffer_number)
          require("twoslash-queries").attach(client, buffer_number)
        end,
        settings = {
          -- tsserver_path = "~/.bun/bin/tsgo",
          -- Performance: separate diagnostic server for large projects
          separate_diagnostic_server = true,
          -- When to publish diagnostics
          publish_diagnostic_on = "insert_leave",
          -- JSX auto-closing tags
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            -- Enable auto imports
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
          },

          tsserver_format_options = {
            insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
            semicolons = "insert",
          },
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          code_lens = "off",
          disable_member_code_lens = true,
          tsserver_max_memory = 12288,
        },
      })
    end,
  },
}
