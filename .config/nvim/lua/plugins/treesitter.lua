return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vue",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      TS.install(opts.ensure_installed)

      -- local mr = require("mason-registry")
      -- mr.refresh(function()
      --   local p = mr.get_package("tree-sitter-cli")
      --   if not p:is_installed() then
      --     vim.notify("Installing `tree-sitter-cli` with `mason.nvim`...")
      --     p:install(
      --       nil,
      --       vim.schedule_wrap(function(success)
      --         if success then
      --           vim.notify("Installed `tree-sitter-cli` with `mason.nvim`.")
      --           TS.install(opts.ensure_installed)
      --         else
      --           vim.notify("Failed to install `tree-sitter-cli` with `mason.nvim`.")
      --         end
      --       end)
      --     )
      --   end
      -- end)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
        callback = function(ev)
          local buf = ev.buf
          local filetype = ev.match
          -- replicate `fold = { enable = true }`
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99 -- keep folds expanded on attach

          -- you need some mechanism to avoid running on buffers that do not
          -- correspond to a language (like oil.nvim buffers), this implementation
          -- checks if a parser exists for the current language
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then
            return
          end

          -- replicate `highlight = { enable = true }`
          vim.treesitter.start(buf, language)

          -- replicate `indent = { enable = true }`
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
}
