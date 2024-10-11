return {
	{
		"supermaven-inc/supermaven-nvim",
		lazy = false,
		enabled = true,
		config = true,
		opts = {
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-,",
			},
		},
		keys = {
			{ "<leader>tsm", "<cmd>SupermavenToggle<cr>", desc = "Toggle SuperMaven" },
		},
	},
	{
		"olimorris/codecompanion.nvim",
		config = true,
		-- config = function()
		-- 	vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		-- 	vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		-- 	vim.api.nvim_set_keymap(
		-- 		"n",
		-- 		"<LocalLeader>a",
		-- 		"<cmd>CodeCompanionChat Toggle<cr>",
		-- 		{ noremap = true, silent = true }
		-- 	)
		-- 	vim.api.nvim_set_keymap(
		-- 		"v",
		-- 		"<LocalLeader>a",
		-- 		"<cmd>CodeCompanionChat Toggle<cr>",
		-- 		{ noremap = true, silent = true }
		-- 	)
		-- 	vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
		--
		-- 	-- Expand 'cc' into 'CodeCompanion' in the command line
		-- 	vim.cmd([[cab cc CodeCompanion]])
		-- end,
	},
	{
		"yetone/avante.nvim",
		enabled = false,
		init = function()
			require("avante_lib").load()
		end,
		event = "VeryLazy",
		opts = {
			hints = { enabled = false },
		},
		build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		optional = true,
		opts = function(_, opts)
			opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
		end,
		ft = function(_, ft)
			vim.list_extend(ft, { "Avante" })
		end,
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			spec = {
				{ "<leader>a", group = "ai" },
			},
		},
	},
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	opts = function(_, opts)
	-- 		table.insert(opts.sources, 1, {
	-- 			name = "supermaven",
	-- 			group_index = 1,
	-- 			priority = 100,
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	enabled = false,
	-- 	"sourcegraph/sg.nvim",
	-- },
}
