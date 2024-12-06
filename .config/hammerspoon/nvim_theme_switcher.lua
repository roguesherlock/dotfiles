-- ~/.hammerspoon/init.lua

-- Add debug logging
local function updateNvimTheme()
	local output, status = hs.execute("pgrep nvim")
	print("Found nvim processes:", output) -- Debug print

	if status then
		for pid in output:gmatch("%d+") do
			print("Sending SIGUSR1 to:", pid) -- Debug print
			local result = hs.execute("kill -SIGUSR1 " .. pid)
			print("Signal result:", result) -- Debug print
		end
	else
		print("No nvim processes found") -- Debug print
	end
end

-- Set up the appearance watcher with debug
local appearanceWatcher = hs.distributednotifications.new(function(name, object, userInfo)
	print("Notification received:", name) -- Debug print
	if name == "AppleInterfaceThemeChangedNotification" then
		print("Theme change detected") -- Debug print
		updateNvimTheme()
	end
end, "AppleInterfaceThemeChangedNotification")

-- Verify watcher is started
local success = appearanceWatcher:start()
print("Watcher started:", success) -- Debug print
