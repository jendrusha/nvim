local M = {}

M.setup = function()
	local cfg = {
		pairs = {
			modes = { insert = true, command = false, terminal = false },
			mappings = {
				['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
				['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
				['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

				[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
				[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
				['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

				['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
				["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
				['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
			},
		},
		surround = {
			n_lines = 20,
			highlight_duration = 500,
			mappings = {
				add = 'sa', -- Add surrounding
				delete = 'sd', -- Delete surrounding
				find = 'sf', -- Find surrounding (to the right)
				find_left = 'sF', -- Find surrounding (to the left)
				highlight = 'sh', -- Highlight surrounding
				replace = 'sr', -- Replace surrounding
				update_n_lines = 'sn', -- Update `n_lines`
			},
		},
		comment = {
			mappings = {
				comment = 'gc',
				comment_line = 'gcc',
				textobject = 'gc',
			},
		},
		trailspace = {
			only_in_normal_buffers = true,
		},
	}

	for plugin, opts in pairs(cfg) do
		require('mini.' .. plugin).setup(opts)
	end
end

return M
