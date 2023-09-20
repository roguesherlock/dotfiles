return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = "<c-/>",
				size = 22,
			})
		end,
	},
}
