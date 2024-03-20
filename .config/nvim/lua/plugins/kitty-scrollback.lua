return {
	"mikesmithgh/kitty-scrollback.nvim",
	enabled = false,
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	-- version = '*', -- latest stable version, may have breaking changes if major version changed
	-- version = '^2.0.0', -- pin major version, include fixes and features that do not have breaking changes
	-- config = function()
	-- 	require("kitty-scrollback").setup()
	-- end,
	opts = {},
}
