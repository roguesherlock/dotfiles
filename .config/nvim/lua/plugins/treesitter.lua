return {
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.autotag = {
				enable = true,
			}
		end,
	},
}
