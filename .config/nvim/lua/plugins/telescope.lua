local actions = require("telescope.actions")

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			-- {
			-- 	"nvim-telescope/telescope-fzf-native.nvim",
			-- 	-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			-- 	build = "make",
			-- 	config = function()
			-- 		require("telescope").load_extension("fzf")
			-- 	end,
			-- },
			-- {
			-- 	"ThePrimeagen/harpoon",
			-- 	config = function()
			-- 		require("telescope").load_extension("harpoon")
			-- 	end,
			-- },
			{
				"danielfalk/smart-open.nvim",
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
				},
				smart_open = {
					theme = "ivy",
				},
				buffers = {
					theme = "ivy",
				},
				git_files = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
				files = {
					theme = "ivy",
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
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
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
				},
			},
		},
	},
}
