-- TODO:
-- [] Add a plugin to automatically fold imports on buffread and after imports
-- [] set buffer type on demand
-- [] format selection or buffer or current line on demand
-- [] nicer terminal experience. Should be able to manipulate terminal buffers like normal buffers
-- [] nicer window management experience. Want to zoom in/out, toggle between splits while still zommed in, etc
-- [] better typescript error formatting

require("config.options")
require("config.keymaps")
require("core.lazy")
require("core.lsp")
require("config.autocmds")
-- require("user.picker").setup()
-- require("user.term").setup()
