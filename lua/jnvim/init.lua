local M = {}

-- {{{1 [ colorscheme func ]
local load_colorscheme = function(scheme)
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
  if not status_ok then
    vim.notify("colorscheme " .. scheme " not found!")
    return
  end
end
-- 1}}}

function M:load()
	require "jnvim.plugins"
	require "jnvim.keymap"

  local colorscheme = "github_dimmed"

  require("jnvim.options").load_options()
	require "jnvim.autocommands"

  load_colorscheme(colorscheme)

	-- colorscheme settings
	-- https://github.com/projekt0n/github-nvim-theme
	require('github-theme').setup({
		theme_style = "dimmed",
		function_style = "italic",
		sidebars = {"qf", "vista_kind", "terminal", "packer", "neo-tree"},
		colors = {hint = "orange", error = "#ff0000"},
		hide_inactive_statusline = true,
		dark_float = true,
		transparent = true,
		overrides = function(c)
			return {
				htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
				DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
				-- this will remove the highlight groups
				TSField = {},
			}
		end
	})

	-- transparent background tweakup
	CMD [[
		hi! GitSignsAdd guibg=none
		hi! GitSignsChange guibg=none
		hi! GitSignsDelete guibg=none
	]]

	require("jnvim.plugins.transparent").setup()
	require("jnvim.plugins.cmp").setup()
	require("jnvim.plugins.lspsignature").setup()
	require("jnvim.plugins.gitsigns").setup()
	require("jnvim.plugins.mini").setup()
	require("jnvim.plugins.nvimblamer").setup()
	require("jnvim.plugins.lualine").setup()
	require("jnvim.plugins.neotree").setup()
	require("jnvim.plugins.dressing").setup()
	require("jnvim.plugins.telescope").setup()
	require("jnvim.plugins.notify").setup()

	require "jnvim.lsp"

	require("funcs.testing").setup()
end

return M
