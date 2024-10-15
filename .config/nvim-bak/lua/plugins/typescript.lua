return {
	{
		"dmmulroy/tsc.nvim",
		config = true,
		cmd = "TSC",
		keys = {
			{ "<leader>ctc", "<cmd>TSC<cr>", desc = "Type-check" },
		},
	},
	-- {
	-- 	ft = {
	-- 		"typescript",
	-- 		"typescriptreact",
	-- 		"typescript.tsx",
	-- 		"javascript",
	-- 		"javascriptreact",
	-- 		"javascript.jsx",
	-- 		"vue",
	-- 	},
	-- 	"pmizio/typescript-tools.nvim",
	-- 	opts = {
	-- 		filetypes = {
	-- 			"javascript",
	-- 			"javascriptreact",
	-- 			"javascript.jsx",
	-- 			"typescript",
	-- 			"typescriptreact",
	-- 			"typescript.tsx",
	-- 			-- "vue",
	-- 		},
	-- 		on_attach = function(client, bufnr)
	-- 			client.server_capabilities.documentFormattingProvider = false
	-- 			client.server_capabilities.documentRangeFormattingProvider = false
	-- 		end,
	-- 		settings = {
	-- 			expose_as_code_action = "all",
	-- 			separate_diagnostic_server = true,
	-- 			composite_mode = "separate_diagnostic",
	-- 			publish_diagnostic_on = "insert_leave",
	-- 			-- tsserver_logs = "verbose",
	-- 			tsserver_plugins = {
	-- 				-- "@vue/typescript-plugin",
	-- 				-- {
	-- 				-- 	name = "@vue/typescript-plugin",
	-- 				-- 	languages = { "vue" },
	-- 				-- },
	-- 			},
	-- 			tsserver_file_preferences = {
	-- 				importModuleSpecifierPreference = "non-relative",
	-- 				includeCompletionsForImportStatements = true,
	-- 				includeAutomaticOptionalChainCompletions = true,
	-- 				includeInlayParameterNameHints = "all",
	-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	-- 				includeInlayFunctionParameterTypeHints = true,
	-- 				includeInlayEnumMemberValueHints = true,
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = function(_, opts)
	-- 		opts.servers["volar"] = {
	-- 			enabled = true,
	-- 		}
	--
	-- 		opts.servers["vtsls"] = {
	-- 			enabled = true,
	-- 			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	-- 			settings = {
	-- 				vtsls = {
	-- 					tsserver = {
	-- 						globalPlugins = {
	-- 							{
	-- 								name = "@vue/typescript-plugin",
	-- 								location = require("mason-registry")
	-- 									.get_package("vue-language-server")
	-- 									:get_install_path() .. "/node_modules/@vue/language-server",
	-- 								languages = { "vue" },
	-- 								configNamespace = "typescript",
	-- 								enableForWorkspaceTypeScriptVersions = true,
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- },
}
