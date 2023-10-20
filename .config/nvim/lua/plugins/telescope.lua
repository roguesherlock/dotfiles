local actions = require("telescope.actions")

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"ThePrimeagen/harpoon",
				config = function()
					require("telescope").load_extension("harpoon")
				end,
			},
			-- already included by lazy
			-- {
			-- 	"nvim-telescope/telescope-fzf-native.nvim",
			-- 	build = "make",
			-- 	config = function()
			-- 		require("telescope").load_extension("fzf")
			-- 	end,
			-- },
			{
				"axkirillov/hbac.nvim",
				config = function()
					require("hbac").setup()
				end,
			},
			{
				"danielfalk/smart-open.nvim",
				dependencies = {
					"kkharji/sqlite.lua",
				},
				config = function()
					require("telescope").load_extension("smart_open")
				end,
			},
		},
		keys = {
			{ "<leader><space>", "<cmd>Telescope smart_open theme=ivy<cr>", desc = "Find Files (smart_open)" },
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						["<Down>"] = actions.cycle_history_next,
						["<Up>"] = actions.cycle_history_prev,
						["<C-n>"] = actions.preview_scrolling_down,
						["<C-p>"] = actions.preview_scrolling_up,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<D-j>"] = actions.move_selection_next,
						["<D-k>"] = actions.move_selection_previous,
						["<ESC>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "ivy",
					sort_mru = true,
				},
				smart_open = {
					theme = "ivy",
					sort_mru = true,
				},
				buffers = {
					theme = "ivy",
					sort_mru = true,
				},
				git_files = {
					theme = "ivy",
					sort_mru = true,
				},
				live_grep = {
					theme = "ivy",
					sort_mru = true,
				},
				files = {
					theme = "ivy",
					sort_mru = true,
				},
				harpoon = {
					theme = "ivy",
				},
				grep_string = {
					theme = "ivy",
				},
				oldfiles = {
					theme = "ivy",
				},
				git_commits = {
					theme = "ivy",
				},
				git_status = {
					theme = "ivy",
				},
				registers = {
					theme = "ivy",
				},
				autocommands = {
					theme = "ivy",
				},
				current_buffer_fuzzy_find = {
					theme = "ivy",
				},
				command_history = {
					theme = "ivy",
				},
				commands = {
					theme = "ivy",
				},
				diagnostics = {
					theme = "ivy",
				},
				help_tags = {
					theme = "ivy",
				},
				highlights = {
					theme = "ivy",
				},
				keymaps = {
					theme = "ivy",
				},
				man_pages = {
					theme = "ivy",
				},
				marks = {
					theme = "ivy",
				},
				vim_options = {
					theme = "ivy",
				},
				resume = {
					theme = "ivy",
				},
				colorscheme = {
					theme = "ivy",
				},
				lsp_document_symbols = {
					theme = "ivy",
				},
				lsp_dynamic_workspace_symbols = {
					theme = "ivy",
				},
				yank_history = {
					theme = "ivy",
				},
				lsp_implementations = {
					theme = "ivy",
				},
				lsp_definitions = {
					theme = "ivy",
				},
				tags = {
					theme = "ivy",
				},
				search_history = {
					theme = "ivy",
				},
				quickfix = {
					theme = "ivy",
				},
				quickfixhistory = {
					theme = "ivy",
				},
				loclist = {
					theme = "ivy",
				},
				jumplist = {
					theme = "ivy",
				},
				spell_suggest = {
					theme = "ivy",
				},
				filetypes = {
					theme = "ivy",
				},
				current_buffer_tags = {
					theme = "ivy",
				},
				pickers = {
					theme = "ivy",
				},
				lsp_references = {
					theme = "ivy",
				},
				lsp_incoming_calls = {
					theme = "ivy",
				},
				lsp_outgoing_calls = {
					theme = "ivy",
				},
				lsp_workspace_symbols = {
					theme = "ivy",
				},
				lsp_type_definitions = {
					theme = "ivy",
				},
				git_bcommits = {
					theme = "ivy",
				},
				git_bcommits_range = {
					theme = "ivy",
				},
				git_branches = {
					theme = "ivy",
				},
				git_stash = {
					theme = "ivy",
				},
				treesitter = {
					theme = "ivy",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
					sort_lastused = true,
				},
				project = {
					base_dirs = {
						{
							"~/Developer",
							max_depth = 3,
						},
					},
					hidden_files = true, -- default: false
					theme = "ivy",
				},
				smart_open = {
					show_scores = false,
					ignore_patterns = { "*.git/*", "*/tmp/*", "node_modules" },
					theme = "ivy",
					cwd_only = true,
				},
			},
		},
	},
}
