return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		keys = {
			{ "<leader>tib", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Blankline" },
			{ "<leader>tis", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Blankline Scope" },
		},
		opts = {
			enabled = false,
			scope = { enabled = true },
		},
	},
}
