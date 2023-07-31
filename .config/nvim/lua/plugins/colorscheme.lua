return {
	-- add gruvbox
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				highlight_groups = {
					IndentBlanklineChar = { fg = "highlight_low" },
					IndentBlanklineContextChar = { fg = "highlight_high" },
					IndentBlanklineContextStart = { sp = "highlight_high" },
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		overrides = function(colors)
			local theme = colors.theme
			return {
				IndentBlanklineChar = { fg = theme.ui.bg_p1 },
				IndentBlanklineContextChar = { fg = theme.ui.bg_p2 },
				IndentBlanklineContextStart = { sp = theme.ui.bg_p2 },
			}
		end,
	},

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			-- colorscheme = "gruvbox"
			-- colorscheme = "catppuccin"
			colorscheme = "rose-pine",
		},
	},
}
