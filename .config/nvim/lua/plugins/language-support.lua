return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, {
					"astro-language-server",
					-- "vue-language-server",
					"intelephense",
					"emmet-language-server",
					"prisma-language-server",
					-- "vtsls", -- typescript language server
				})
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.autotag = {
				enable = true,
			}
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "astro", "vue", "php", "prisma" })
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				nix = { "nixpkgs_fmt" },
			},
		},
	},
}
