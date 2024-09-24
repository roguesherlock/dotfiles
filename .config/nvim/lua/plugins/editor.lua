return {
	{
		"chrisgrieser/nvim-recorder",
		keys = {
			-- these must match the keys in the mapping config below
			{ "q", desc = " Start Recording" },
			{ "Q", desc = " Play Recording" },
		},
		opts = {
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
			},
		},
	},
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"gb",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		opts = {},
	},
	{
		"folke/zen-mode.nvim",
		dependencies = {
			"folke/twilight.nvim",
		},
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
		},
	},
	{
		"akinsho/toggleterm.nvim",
		enabled = true,
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = "<c-/>",
				size = 22,
			})
		end,
		keys = {
			{ "<c-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				position = "right",
				fuzzy_finder_mappings = {
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
		},
	},
	{
		"NeogitOrg/neogit",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
		},
		config = function()
			require("neogit").setup({
				integrations = {
					telescope = true,
					diffview = true,
				},
			})
		end,
		keys = {
			{ "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				blade = { "blade-formatter" },
			},
		},
	},
}
