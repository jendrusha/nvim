local M = {}

M.setup = function()
	local opts = {
		options = {
			theme = "auto",
			component_separators = {'', ''},
			section_separators = {'', ''},
			disabled_filetypes = { 'toggleterm', "neo-tree" },
		},
		sections = {
			lualine_a = {{'filename', path = 2}},
			lualine_b = {'branch', {
				'diff',
				-- color_added = 'green',
				-- color_modified = 'yellow',
				-- color_removed = 'red'
			}},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {{'location'}},
			lualine_z = {{'progress'}}
		},
	}
	require('lualine').setup(opts)
end

return M
