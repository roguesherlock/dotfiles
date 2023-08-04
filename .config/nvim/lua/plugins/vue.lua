return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "vue-language-server")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.autotag = {
				enable = true,
			}
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "vue" })
			end
		end,
	},
}
