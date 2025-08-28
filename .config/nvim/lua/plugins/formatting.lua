return {
  -- Conform for formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      local map = require("user.util").map

      -- use deno_fmt if in deno project, otherwise prettier
      local javascript_formatter = function(bufnr)
        local lsp_clients = vim.lsp.get_clients()
        for _, client in pairs(lsp_clients) do
          if client.name == "denols" then
            return { "deno_fmt" }
          end
          if client.name == "biome" then
            return { "biome" }
          end
        end
        return { "prettier" }
      end

      require("conform").setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          local lsp_format_opt
          if disable_filetypes[vim.bo[bufnr].filetype] then
            lsp_format_opt = "never"
          else
            lsp_format_opt = "fallback"
          end
          return {
            timeout_ms = 3000,
            lsp_format = lsp_format_opt,
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          blade = { "blade-formatter" },
          json = javascript_formatter,
          jsx = javascript_formatter,
          javascript = javascript_formatter,
          typescript = javascript_formatter,
          typescriptreact = javascript_formatter,
          javascriptreact = javascript_formatter,
          svelte = javascript_formatter,
          vue = javascript_formatter,
          html = javascript_formatter,
          css = javascript_formatter,
          graphql = { "prettier" },
          markdown = javascript_formatter,
          yaml = javascript_formatter,
          php = { "pint" },
        },
      })

      map("n", "<leader>bf", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end, { desc = "[B]uffer [F]ormat" })

      map("n", "<leader>tf", function()
        if vim.b.disable_autoformat then
          vim.b.disable_autoformat = false
          vim.notify("Enabled buffer autoformat", vim.log.levels.INFO)
        else
          vim.b.disable_autoformat = true
          vim.notify("Disabled buffer autoformat", vim.log.levels.INFO)
        end
      end, { desc = "[T]oggle Buffer [F]ormat" })

      map("n", "<leader>tF", function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          vim.notify("Enabled workspace autoformat", vim.log.levels.INFO)
        else
          vim.g.disable_autoformat = true
          vim.notify("Disabled workspace autoformat", vim.log.levels.INFO)
        end
      end, { desc = "[T]oggle Workspace [F]ormat" })
    end,
  },

  -- Nvim-lint for linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
