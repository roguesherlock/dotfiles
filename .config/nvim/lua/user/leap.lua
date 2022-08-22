local leap_status_ok, leap = pcall(require, "leap")
if not leap_status_ok then
	return
end
leap.set_default_keymaps()