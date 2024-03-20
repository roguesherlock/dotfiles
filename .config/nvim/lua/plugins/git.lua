return {
	{
		enabled = false,
		"NeogitOrg/neogit",
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
}
