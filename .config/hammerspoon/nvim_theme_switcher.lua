-- ~/.hammerspoon/init.lua (or add to your existing config)

-- Watch for system appearance changes
local function updateNvimTheme()
	-- Find all nvim processes and send SIGUSR1
	local output, status = hs.execute("pgrep nvim")
	if status then
		for pid in output:gmatch("%d+") do
			hs.execute("kill -SIGUSR1 " .. pid)
		end
	end
end

-- Set up the appearance watcher
local appearanceWatcher = hs.distributednotifications.new(function(name, object, userInfo)
	if name == "AppleInterfaceThemeChangedNotification" then
		updateNvimTheme()
	end
end)

appearanceWatcher:start()

-- Optional: Add a menu bar item to manually trigger theme update
local menuItem = hs.menubar.new()
if menuItem then
	menuItem:setTitle("🎨")
	menuItem:setClickCallback(function()
		updateNvimTheme()
	end)
end
