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

  local colorscheme = "github_light_colorblind"

  require("jnvim.options").load_options()
	require "jnvim.autocommands"

  load_colorscheme(colorscheme)

	-- colorscheme settings
	-- https://github.com/projekt0n/github-nvim-theme
	require('github-theme').setup({
		theme_style = "light_colorblind",
		function_style = "italic",
		sidebars = {"qf", "vista_kind", "terminal", "packer", "neo-tree"},
		colors = {hint = "orange", error = "#ff0000"},
		hide_inactive_statusline = true,
		dark_float = false,
		transparent = true,
		overrides = function(c)
			return {
				htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
				DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
				-- this will remove the highlight groups
				-- TSField = {},
			}
		end
	})

	require 'colorizer'.setup({
		'yaml';
		'css';
		'ini';
		'lua';
		html = { mode = 'background' };
	}, {
			mode = 'foreground',
			RRGGBBAA = true,
	})

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
	require("jnvim.plugins.autopairs").setup()
	require("jnvim.plugins.dap").setup()

	require "jnvim.lsp"

	require("funcs.testing").setup()

	-- transparent background tweakup
	CMD [[
		hi! NeoTreeGitConflict guifg=#b0761e
		hi! NeoTreeGitUntracked guifg=#b0761e
		hi! GitSignsAdd guibg=none
		hi! GitSignsChange guibg=none
		hi! GitSignsDelete guibg=none
		hi! VertSplit guibg=none
	]]
end

return M
