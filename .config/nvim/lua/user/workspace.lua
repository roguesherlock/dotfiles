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

--[[ load the session for the given workspace name, or the current workspace if no workspace name is given ]]
local function load_session(workspace_name)
	local session_filepath = workspace_name or workspaces.name()
	if session_filepath then
		session_filepath = vim.fn.stdpath("cache") .. "/sessions/" .. session_filepath .. ".session"
	end
	if not sessions.load(session_filepath, { silent = true }) then
		sessions.save(session_filepath, { silent = true })
	end
end

--[[ create a session file for the current workspace if it doesn't exist ]]
local function maybe_create_session()
	local cwd = vim.fn.getcwd()
	local workspaces_list = workspaces.get()
	for _, workspace in ipairs(workspaces_list) do
		if string.find(workspace.path, cwd) then
			load_session(workspace.name)
			return
		end
	end
end

workspaces.setup({
	hooks = {
		add = maybe_create_session,
		open_pre = {
			"SessionsStop",
			"silent %bdelete!",
		},
		open = load_session,
	},
})

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end
telescope.load_extension("workspaces")
