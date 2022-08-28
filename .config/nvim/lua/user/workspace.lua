local workspaces_status_ok, workspaces = pcall(require, "workspaces")
if not workspaces_status_ok then
	return
end

local sessions_status_ok, sessions = pcall(require, "sessions")
if not sessions_status_ok then
	return
end

sessions.setup({
	-- autocmd events which trigger a session save
	--
	-- the default is to only save session files before exiting nvim.
	-- you may wish to also save more frequently by adding "BufEnter" or any
	-- other autocmd event
	events = { "VimLeavePre", "WinEnter", "BufEnter" },

	-- default session filepath (relative)
	--
	-- if a path is provided here, then the path argument for commands and API
	-- functions will use session_filepath as a default if no path is provided.
	--[[ session_filepath = vim.fn.stdpath("cache") .. "/sessions", ]]
})

workspaces.setup({
	hooks = {
		open_pre = {
			"SessionsStop",
			"silent %bdelete!",
		},
		open = function()
			local session_filepath = workspaces.name()
			if session_filepath then
				session_filepath = vim.fn.stdpath("cache") .. "/sessions/" .. session_filepath .. ".session"
			end
			if not sessions.load(session_filepath, { silent = true }) then
				sessions.save(session_filepath, { silent = true })
			end
		end,
	},
})

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end
telescope.load_extension("workspaces")
