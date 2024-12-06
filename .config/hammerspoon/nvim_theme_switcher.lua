-- Make updateNvimTheme global to ensure it's available
_G.updateNvimTheme = function()
	local output, status = hs.execute("pgrep nvim")
	-- print("[DEBUG] Found nvim processes:", output)
	if status then
		for pid in output:gmatch("%d+") do
			-- print("[DEBUG] Sending SIGUSR1 to:", pid)
			-- 30 = SIGUSR1 (only on macos)
			-- hs.execute("kill -SIGUSR1 " .. pid, true)
			local result = hs.execute("kill -s 30 " .. pid)
			-- print("[DEBUG] Signal result:", result)
		end
	end
end

-- Set up the appearance watcher and store in global scope
_G.appearanceWatcher = hs.distributednotifications
	.new(function(name)
		-- print("[DEBUG] Received notification:", name)
		_G.updateNvimTheme()
	end, "AppleInterfaceThemeChangedNotification")
	:start()
-- print("[DEBUG] Appearance watcher started")
