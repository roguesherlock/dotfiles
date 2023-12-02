return {
	{
		"folke/which-key.nvim",
		opts = {
			defaults = {
				["<leader>z"] = { name = "Zen" },
				-- ["<leader>j"] = { name = "Find Files (Git)" },
				-- ["<leader>sl"] = { name = "Live Grep (with args)" },
				["<leader><tab>"] = { name = "Buffer list (with preview)" },
				["<leader>t"] = { name = "+tabs" },
				["<leader>m"] = { name = "+harpoon" },
				["<leader>gn"] = { name = "Neogit" },
			},
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for keymaps that start with a native binding
				i = { "j", "k", "f" },
				v = { "j", "k" },
			},
		},
	},
}
