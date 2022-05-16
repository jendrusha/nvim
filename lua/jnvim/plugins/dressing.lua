local M = {}

M.setup = function()
	local opts = {
		input = {
			default_prompt = "➤ ",
			insert_only = true,
			anchor = "SW",
			relative = "cursor",
			border = "rounded",
			prefer_width = 40,
			max_width = nil,
			min_width = 20,
			winblend = 10,
			winhighlight = "",
			get_config = nil,
		},
		select = {
			backend = { "telescope", "fzf", "builtin", "nui" },
			fzf = {
				window = {
					width = 0.5,
					height = 0.4,
				},
			},
			nui = {
				position = "50%",
				size = nil,
				relative = "editor",
				border = {
					style = "rounded",
				},
				max_width = 80,
				max_height = 40,
			},
			builtin = {
				anchor = "NW",
				relative = "cursor",
				border = "rounded",
				winblend = 10,
				winhighlight = "",
				width = nil,
				max_width = 0.8,
				min_width = 40,
				height = nil,
				max_height = 0.9,
				min_height = 10,
			},
			format_item_override = {},
			get_config = nil,
		},
	}

	require('dressing').setup(opts)
end

return M
