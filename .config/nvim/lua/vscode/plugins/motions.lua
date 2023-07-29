return {
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat"
    },
    init = function()
      require("leap").add_default_mappings()
    end
  },
  {
    "tpope/vim-surround"
  }
  -- {
  --   "numToStr/Comment.nvim",
  --   config = function()
  --     require("Comment").setup()
  --   end
  -- },
  -- {
  --   "windwp/nvim-ts-autotag"
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   init = function()
  --     require("nvim-treesitter.configs").setup {
  --       -- Install the parsers for the languages you want to comment in
  --       -- Here are the supported languages:
  --       ensure_installed = {
  --         "astro",
  --         "css",
  --         "glimmer",
  --         "graphql",
  --         "handlebars",
  --         "html",
  --         "javascript",
  --         "lua",
  --         "nix",
  --         "php",
  --         "python",
  --         "rescript",
  --         "scss",
  --         "svelte",
  --         "tsx",
  --         "twig",
  --         "typescript",
  --         "vim",
  --         "vue"
  --       },
  --
  --       context_commentstring = {
  --         enable = true
  --       }
  --     }
  --   end,
  --   dependencies = {
  --     "JoosepAlviste/nvim-ts-context-commentstring"
  --   }
  -- }
}
