local M = {}

M.setup = function()
	local opts = {
		defaults = {
			theme = "dropdown",
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case"
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			-- sorting_strategy = "descending",
			-- layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					prompt_position = "top",
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120
			},
			file_sorter = require "telescope.sorters".get_fuzzy_file,
			file_ignore_patterns = {},
			generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
			winblend = 0,
			border = {},
			borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
			color_devicons = true,
			use_less = true,
			set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
			file_previewer = require "telescope.previewers".vim_buffer_cat.new,
			grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
			qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
		},
		buffers = {
			theme = "dropdown",
		},
		pickers = {
			find_files = {
				theme = "dropdown",
			}
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case" -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		}
	}

	require('telescope').setup(opts)
	require("telescope").load_extension("fzf")
	-- require('telescope').load_extension('dap')
end

return M
