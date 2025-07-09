-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap and setup lazy.nvim
require("config.lazy")

-- setup lsp after loading plugins
require("config.lsp")
