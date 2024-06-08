return {
	{
		"akinsho/toggleterm.nvim",
		enabled = false,
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
}
