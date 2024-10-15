return {
	{
		"hrsh7th/nvim-cmp",
		-- enabled = false,
		keys = {
			{ "<tab>", false, mode = { "i", "s" } },
			{ "<s-tab>", false, mode = { "i", "s" } },
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			-- local has_words_before = function()
			-- 	unpack = unpack or table.unpack
			-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			-- 	return col ~= 0
			-- 		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			-- end
			--
			-- local luasnip = require("luasnip")
			local cmp = require("cmp")
			opts.window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			}

			opts.mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-j>"] = cmp.mapping.select_next_item({
					behavior = cmp.SelectBehavior.Select,
				}),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-p>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {
					"i",
					"c",
				}),
				["<C-n>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {
					"i",
					"c",
				}),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {
					"i",
					"c",
				}),
				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if vim.snippet.jumpable(1) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
					end
					-- if luasnip.expand_or_locally_jumpable() then
					-- 	luasnip.expand_or_jump()
					-- end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if vim.snippet.jumpable(-1) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
					end
					-- if luasnip.locally_jumpable(-1) then
					-- 	luasnip.jump(-1)
					-- end
				end, { "i", "s" }),
			})
		end,
	},
	{
		"saghen/blink.cmp",
		enabled = false,
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",
		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		opts = {
			keymap = {
				show = "<C-space>",
				hide = "<C-e>",
				accept = "<C-y>",
				-- accept = "<Cr>",
				select_prev = { "<Up>", "<C-k>" },
				select_next = { "<Down>", "<C-j>" },
				show_documentation = {},
				hide_documentation = {},
				scroll_documentation_up = "<C-p>",
				scroll_documentation_down = "<C-n>",
				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				snippet_forward = "<C-l>",
				snippet_backward = "<C-h>",
			},
			-- windows = {
			-- 	autocomplete = {
			-- 		border = "rounded",
			-- 	},
			-- },
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				-- use_nvim_cmp_as_default = true,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = "normal",
			-- experimental auto-brackets support
			-- accept = { auto_brackets = { enabled = true } }

			-- experimental signature help support
			trigger = { signature_help = { enabled = true } },
		},
	},
}
