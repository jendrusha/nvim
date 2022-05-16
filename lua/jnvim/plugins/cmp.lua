local M = {}

local cmp = require('cmp')
local lspkind = require('lspkind')

M.setup = function()
	local opts = {
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
		sources = cmp.config.sources({
			{ name = 'nvim_lsp', max_item_count = 6 },
			{ name = 'vsnip',max_item_count = 3 },
			{ name = 'cmp_tabnine', max_item_count = 3 },
			{ name = 'nvim_lsp_signature_help' },
		}, {
			{ name = 'path', max_item_count = 3 },
		}, {
      { name = 'buffer', max_item_count = 3, keyword_length = 3, option = { get_bufnrs = vim.api.nvim_list_bufs } },
		}),
		mapping = {
				['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.close(),
				['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
				}),
				['<Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end
		},
		formatting = {
				format = lspkind.cmp_format({
						with_text = true,
						maxwidth = 50,
						menu = {
								buffer = "[buf]",
								treesitter = "[treesitter]",
								nvim_lsp = "[lsp]",
								nvim_lua = "[api]",
								path = "[path]",
								spell = "[spell]",
								vsnip = "[vsnip]",
								cmp_tabnine = "[tn]",
						},
				}),
		},
		sorting = {
				priority_weight = 2,
				comparators = {
						-- require('cmp_tabnine.compare'),
						-- cmp.config.compare.offset,
						-- cmp.config.compare.exact,
						-- cmp.config.compare.score,
						-- cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						-- cmp.config.compare.length,
						-- cmp.config.compare.order,
				}
		},
		preselect = cmp.PreselectMode.None,

		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		}),
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})
	}

	cmp.setup(opts)

	local tabnine = require('cmp_tabnine.config')
	tabnine:setup({
		max_lines = 1000;
		max_num_results = 10;
		sort = true;
		run_on_every_keystroke = true;
		snippet_placeholder = '..';
		ignored_file_types = { -- default is not to ignore
			-- uncomment to ignore in lua:
			-- lua = true
		};
		show_prediction_strength = true;
	})
end

return M

