local function updateNvimTheme()
	local output, status = hs.execute("pgrep nvim")
	print("Found nvim processes:", output) -- Debug print

	if status then
		for pid in output:gmatch("%d+") do
			print("Sending SIGUSR1 to:", pid) -- Debug print
			local result = hs.execute("kill -SIGUSR1 " .. pid, true)
			print("Signal result:", result) -- Debug print
		end
	else
		print("No nvim processes found") -- Debug print
	end
end

-- Set up the appearance watcher with debug
local appearanceWatcher = hs.distributednotifications.new(function(name)
	print("[DEBUG] Distributed notification received:", name)
	if name == "AppleInterfaceThemeChangedNotification" then
		print("[DEBUG] Theme change detected")
		updateNvimTheme()
	else
		print("[DEBUG] Ignored notification:", name)
	end
end, "AppleInterfaceThemeChangedNotification")

local success = appearanceWatcher:start()
print("[DEBUG] Watcher started:", success)
