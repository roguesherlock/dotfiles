-- bootstrap lazy.nvim, LazyVim and your plugins
-- TODO:
--  X. add colorscheme plugin to auto update other apps' themes -- it only took me like 10 hours
--  2. figure out why is the sign column not working properly for modus theme
--  3. add proper modus themes for other apps
--  4. update the lualine. Don't need that breadcrumbs thing
--  5. figure out why is saving twice
--  6. why does the homepage show the signcolumn?
--  7. why does neovim resize the terminal?
--  8. Ability to ask ai for errors from typescript
--  9. Ability to search all files in the cwd (projec)
-- 10. Figure out why the fuck does lazyvim override my keymaps
-- 11. Set import preferences for typescript lsp
-- 12. Don't use ai completions with blink.nvim
-- 13. blink.nvim shouldn't insert when moving between options with ctrl-n/p

require("config.lazy")
