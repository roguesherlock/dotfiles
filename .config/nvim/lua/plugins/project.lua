return {
	{
		"coffebar/neovim-project",
		opts = {
			projects = { -- define project roots
				"~/Developer/*",
			},
		},
		init = function()
			-- enable saving the state of plugins in the session
			vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
		end,
		dependencies = { "nvim-telescope/telescope.nvim", "Shatur/neovim-session-manager" },
		lazy = false,
		priority = 100,
		keys = {
			{ "<leader>fp", "<Cmd>Telescope neovim-project discover theme=ivy<CR>", desc = "All Projects" },
			{ "<leader>fP", "<Cmd>Telescope neovim-project history theme=ivy<CR>", desc = "Recent Projects" },
		},
	},
	{
		"goolord/alpha-nvim",
		optional = true,
		opts = function(_, dashboard)
			local button =
				dashboard.button("p", " " .. " Projects", ":Telescope neovim-project discover theme=ivy <CR>")
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
			table.insert(dashboard.section.buttons.val, 4, button)
		end,
	},
}
