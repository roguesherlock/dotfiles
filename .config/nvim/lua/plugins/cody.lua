return {
	enabled = false,
	"sourcegraph/sg.nvim",
	event = "InsertEnter",
	cmd = { "CodyAsk", "CodyChat", "SourcegraphLink", "SourcegraphLogin" },
	keys = {
		{ "<D-i>", "<cmd>CodyToggle<cr>", desc = "Toggle Cody Chat" },
	},
	opts = {},
}
