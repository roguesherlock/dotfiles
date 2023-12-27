return {
	{
		"dmmulroy/tsc.nvim",
		config = true,
		cmd = "TSC",
		keys = {
			{ "<leader>ctc", "<cmd>TSC<cr>", desc = "Type-check" },
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		opts = {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			settings = {
				expose_as_code_action = "all",
				separate_diagnostic_server = true,
				composite_mode = "separate_diagnostic",
				publish_diagnostic_on = "insert_leave",
				-- tsserver_logs = "verbose",
				tsserver_file_preferences = {
					importModuleSpecifierPreference = "non-relative",
					includeCompletionsForImportStatements = true,
					includeAutomaticOptionalChainCompletions = true,
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},
}
