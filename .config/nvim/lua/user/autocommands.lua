-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

--[[ Autosave ]]
vim.api.nvim_create_autocmd({ "TextChanged", "FocusLost", "BufEnter", "InsertLeave" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[ silent! update ]])
	end,
})

--[[ AutoFormat ]]
--[[ vim.api.nvim_create_autocmd({ "BufWritePre" }, { ]]
--[[   pattern = { "*" }, ]]
--[[   callback = function() ]]
--[[     vim.lsp.buf.formatting_sync({}, {}, {'null-ls'}) ]]
--[[   end ]]
--[[ }) ]]
--[[]]

--local function write_buf_timer()
--    vim.fn.timer_start(1000, function()
--        vim.api.nvim_command([[ silent! update ]])
--    end)
--end
--
--vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = write_buf_timer })

-- Create directory on save if it doesn't exist
--[[ vim.api.nvim_create_autocmd('BufWritePre', { ]]
--[[   group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }), ]]
--[[   callback = function(ctx) ]]
--[[     vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ':p:h'), 'p') ]]
--[[   end ]]
--[[ }) ]]

--[[    You might prefer to keep the info with the session.  You will have to do ]]
--[[ this yourself then.  Example: ]]
--[[]]
--[[ 	:mksession! ~/.config/nvim/secret.vim ]]
--[[ 	:wshada! ~/.local/state/nvim/shada/secret.shada ]]
--[[]]
--[[ And to restore this again: ]]
--[[]]
--[[ 	:source ~/.config/nvim/secret.vim ]]
--[[ 	:rshada! ~/.local/state/nvim/shada/secret.shada ]]

local function maybe_load_workspace()
	local cwd = vim.fn.getcwd()
	local status, workspaces = pcall(require, "workspaces")
	if not status then
		return
	end
	local workspaces_list = workspaces.get()
	for _, workspace in ipairs(workspaces_list) do
		if string.find(workspace.path, cwd) then
			workspaces.open(workspace.name)
			return
		end
	end
end
vim.api.nvim_create_autocmd(
	{ "VimEnter" },
	{
		group = vim.api.nvim_create_augroup("auto_load_workspace", { clear = true }),
		nested = true,
		callback = maybe_load_workspace,
	}
)
