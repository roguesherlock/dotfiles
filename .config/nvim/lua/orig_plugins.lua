_ = vim.cmd [[packadd packer.nvim]]
_ = vim.cmd [[packadd vimball]]

return require("packer").startup {
  function(use)
		-- Packer can manage itself
		use "wbthomason/packer.nvim"

		-- Speed up loading Lua modules in Neovim to improve startup time.
		use {
			'lewis6991/impatient.nvim',
			-- this is only here cause packer somewhow wants to remove itself aotherwise lol
			requires = "wbthomason/packer.nvim"
		}



		-- manage lsp plugins
		use {
			"williamboman/mason.nvim",
			config = function() require("mason").setup {} end
		}
		use { "williamboman/mason-lspconfig.nvim" }
		use { "WhoIsSethDaniel/mason-tool-installer.nvim" }
		use { "neovim/nvim-lspconfig" }
		use {"jose-elias-alvarez/null-ls.nvim" }
		use "j-hui/fidget.nvim" -- lsp status in statusline


		-- nvim notify
		use "rcarriga/nvim-notify"


		-- Plug 'tpope/vim-fugitive'                   " git wrapper

		-- allow operations on surroundings({''}) in pairs
		use 'tpope/vim-surround'

		-- handle buffers
		use 'mhinz/vim-sayonara'

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


	-- Plug 'tpope/vim-commentary'                 " comments

		-- Use dependency and run lua function after load
		use {
			'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
		}

		-- lovely syntax highlighting
		use {
			'nvim-treesitter/nvim-treesitter',
			'nvim-treesitter/nvim-treesitter-context',
			run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		}

		--
		use "tpope/vim-sleuth"

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
		use 'christoomey/vim-sort-motion'

		-- auto rename html
		use "windwp/nvim-ts-autotag"

		-- braces
		use {
			'windwp/nvim-autopairs',
			config = function() require("nvim-autopairs").setup {} end
		}
		use {
			"cohama/lexima.vim"
		}

		-- indent guides
		require("packer").startup(function()
			use "lukas-reineke/indent-blankline.nvim"
		end)

		-- Fine grained syntax highlighting for JSON
		use 'Elzr/Vim-json'

		-- undo visualizer
		-- use 'sjl/gundo.vim'

		use "godlygeek/tabular" -- Quickly align text by pattern

		-- Advanced repeat (think '.' repeat for complex operations)
		use 'tpope/vim-repeat'
		use "tpope/vim-abolish" -- Cool things with words!
		use "tpope/vim-characterize"
		use { "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } }

		-- open git commits in 3 window mode
		use "rhysd/committia.vim"

		-- open git commit message of a line in window
		use {
			"rhysd/git-messenger.vim",
			keys = "<Plug>(git-messenger)",
		}


		-- comments
		use 'preservim/nerdcommenter'

		-- find files
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
			requires = { {'nvim-lua/plenary.nvim'} }
		}

		use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } -- c port fzf
		use { "nvim-telescope/telescope-hop.nvim" }
		use { "nvim-telescope/telescope-file-browser.nvim" } -- file browser
		use { "nvim-telescope/telescope-ui-select.nvim" }
		use { "nvim-telescope/telescope-frecency.nvim" } -- intelligent prioritization when selecting files from your editing history.

		-- curl wrapper for nvim
		use {
			"NTBBloodbath/rest.nvim",
			config = function()
				require("rest-nvim").setup()
			end,
		}

		-- fix some cursor hold bug that makes certain plugins delay
		use {
			"antoinemadec/FixCursorHold.nvim",
			run = function()
				vim.g.curshold_updatime = 1000
			end,
		}

		-- PRACTICE:
		use {
			"tpope/vim-projectionist", -- STREAM: Alternate file editting and some helpful stuff,
			enable = false,
		}
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

		-- status bar
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}

		-- diff view
		use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

		-- leap
		use 'ggandor/leap.nvim'

		--   FOCUSING:
		local use_folke = true
		if use_folke then
			use "folke/zen-mode.nvim"
			use "folke/twilight.nvim"
		else
			use {
				"junegunn/goyo.vim", -- distraction free mode
				cmd = "Goyo",
				disable = use_folke,
			}

			use {
				"junegunn/limelight.vim", -- highlight paragrams in distraction free mode
				after = "goyo.vim",
				disable = use_folke,
			}
		end

		-- Sql
		use "tpope/vim-dadbod"
		use { "kristijanhusak/vim-dadbod-completion" }
		use { "kristijanhusak/vim-dadbod-ui" }

		-- find and replace
		use {
			"windwp/nvim-spectre",
			requires = { "nvim-lua/plenary.nvim" }
		}

		-- jump to definitions
		use "pechorin/any-jump.vim"

		-- themes
		use {'dracula/vim', as = 'dracula'}
		use {'gruvbox-community/gruvbox', as = 'gruvbox'}

		if packer_bootstrap then
			require('packer').sync()
		end
  end,

  config = {
    luarocks = {
      python_cmd = "python3",
    },
    display = {
      open_fn = require('packer.util').float,
    },
  },
}
