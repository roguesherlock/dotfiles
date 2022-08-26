local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  --[[ use { "numToStr/FTerm.nvim" } ]]
  use { "ahmedkhalf/project.nvim" }
  use { "lewis6991/impatient.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }

  -- Colorschemes
  use { "folke/tokyonight.nvim" }
  use { "lunarvim/darkplus.nvim" }
  use { "dracula/vim", as = "dracula" }
  -- use { "gruvbox-community/gruvbox", as = "gruvbox" }
  -- use { "morhetz/gruvbox" }
  use { "ellisonleao/gruvbox.nvim" }
  --[[ use { "projekt0n/github-nvim-theme" } ]]
  use { "B4mbus/oxocarbon-lua.nvim" }
  --[[ use { "shaunsingh/oxocarbon.nvim", run = "./install.sh" } ]]
  use { "catppuccin/nvim", as = "catppuccin" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-copilot" }
  use { "github/copilot.vim" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  } -- lsp config and installers
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" }
  use { "j-hui/fidget.nvim" } -- lsp status in statusline

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "arch -arm64 make" } -- c port fzf
  use { "nvim-telescope/telescope-project.nvim" }
  use { "nvim-telescope/telescope-file-browser.nvim" } -- file browser
  use { "nvim-telescope/telescope-ui-select.nvim" }
  use { "nvim-telescope/telescope-frecency.nvim" } -- intelligent prioritization when selecting files from your editing history.

  -- curl wrapper for nvim
  use {
    "NTBBloodbath/rest.nvim",
    opt = true,
    config = function()
      require("rest-nvim").setup()
    end,
  }

  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- DAP
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "ravenxrz/DAPInstall.nvim" }


  --tpope stuf
  use { "tpope/vim-surround" }
  use { "tpope/vim-sleuth" }
  -- Advanced repeat (think "." repeat for complex operations)
  use { "tpope/vim-repeat" }
  use { "tpope/vim-abolish" } -- Cool things with words!
  use { "tpope/vim-characterize" }
  use { "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } }


  -- diff view
  use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }

  -- leap
  use { "ggandor/leap.nvim" }

  -- Focussing
  use { "folke/zen-mode.nvim" }
  use { "folke/twilight.nvim" }

  -- Sql
  use { "tpope/vim-dadbod" }
  use { "kristijanhusak/vim-dadbod-completion" }
  use { "kristijanhusak/vim-dadbod-ui" }

  -- For narrowing regions of text to look at them alone
  use {
    "chrisbra/NrrwRgn",
    cmd = { "NarrowRegion", "NarrowWindow" },
  }

  -- Crazy good box drawing
  use "gyim/vim-boxdraw"


  -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- select things
  use {
    "RRethy/nvim-treesitter-textsubjects",
    config = function()
      require('nvim-treesitter.configs').setup {
        textsubjects = {
            enable = true,
            prev_selection = ',', -- (Optional) keymap to select the previous selection
            keymaps = {
                ['.'] = 'textsubjects-smart',
                [';'] = 'textsubjects-container-outer',
                ['i;'] = 'textsubjects-container-inner',
            },
        },
      }
    end
  }
  use {
    "Julian/vim-textobj-variable-segment",
    requires = { {"kana/vim-textobj-user"} }
  }

  -- sort lines
  --[[ use 'christoomey/vim-sort-motion' ]]

  -- auto rename html
  use "windwp/nvim-ts-autotag"

  -- handle windows
  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }
  -- Or lazy load with `module` option. See further down for info on how to lazy load when using FocusSplit commands
  -- Or lazy load this plugin by creating an arbitrary command using the cmd option in packer.nvim
  -- use { 'beauwilliams/focus.nvim', cmd = { "FocusSplitNicely", "FocusSplitCycle" }, module = "focus",
  --     config = function()
  --         require("focus").setup({hybridnumber = true})
  --     end
  -- }
  use {
    "ThePrimeagen/harpoon",
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- nvim notify
  use "rcarriga/nvim-notify"


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
