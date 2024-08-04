return {
	{
		"supermaven-inc/supermaven-nvim",
		lazy = false,
		enabled = false,
		config = true,
		keys = {
			{ "<leader>tsm", "<cmd>SupermavenToggle<cr>", desc = "Toggle SuperMaven" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			-- table.insert(opts.sources, 1, {
			-- 	name = "supermaven",
			-- 	group_index = 1,
			-- 	priority = 100,
			-- })
		end,
	},
}
