return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			table.insert(opts.sources, 1, {
				name = "supermaven",
				group_index = 1,
				priority = 100,
			})
		end,
	},
}
