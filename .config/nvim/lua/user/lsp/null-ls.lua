local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = true,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr, async = true })
					--[[ local status, _result = pcall(vim.lsp.buf.format, { bufnr = bufnr }) ]]
					--[[ local status, _result = pcall(vim.lsp.buf.formatting_sync) ]]
					--[[ if not status then ]]
					--[[   print("Couldn't format file") ]]
					--[[   return ]]
					--[[ end ]]
				end,
			})
		end
	end,
	sources = {
		--[[ formatting.prettier, ]]
		formatting.prettierd,
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.google_java_format,
		formatting.gofmt,
		formatting.goimports,
		diagnostics.flake8,
	},
})
