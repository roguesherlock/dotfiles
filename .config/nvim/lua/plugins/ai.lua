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
	-- {
	-- 	enabled = false,
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
	-- 	opts = {
	-- 		-- add any opts here
	-- 	},
	-- 	dependencies = {
	-- 		--- The below is optional, make sure to setup it properly if you have lazy=true
	-- 		{
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
}
