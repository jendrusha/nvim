local M = {}

M.setup = function()
	local opts = {
		enable = true,
		format = "%author │ %author-time-human │ %summary",
		prefix = "  ",
		auto_hide = false,
		hide_delay = 1000,
		show_error = false,
	}

	require'nvim-blamer'.setup(opts)
end

return M
