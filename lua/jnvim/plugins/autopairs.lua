local M = {}

M.setup = function()
	local npairs = require("nvim-autopairs")
	local Rule = require('nvim-autopairs.rule')
	local ts_conds = require('nvim-autopairs.ts-conds')

  local ts_config = {
		lua = {'string'},-- it will not add a pair on that treesitter node
		javascript = {'template_string'},
		go = {'string'},
		java = false,-- don't check treesitter on java
	}

	local opts = {
		disable_filetype = { "TelescopePrompt" },
		disable_in_macro = false,  -- disable when recording or executing a macro
		disable_in_visualblock = false, -- disable when insert after visual block mode
		ignored_next_char = [=[[%w%%%'%[%"%.]]=],
		enable_moveright = true,
		enable_afterquote = true,  -- add bracket pairs after quote
		enable_check_bracket_line = true,  --- check bracket in same line
		enable_bracket_in_quote = true, --
		check_ts = true,
		ts_confi = ts_config,
		map_cr = true,
		map_bs = true,  -- map the <BS> key
		map_c_h = false,  -- Map the <C-h> key to delete a pair
		map_c_w = false, -- map <c-w> to delete a pair if possible
	}

	npairs.setup(opts)

	-- press % => %% only while inside a comment or string
	npairs.add_rules({
		Rule("%", "%", "lua")
			:with_pair(ts_conds.is_ts_node({'string','comment'})),
		Rule("$", "$", "lua")
			:with_pair(ts_conds.is_not_ts_node({'function'}))
	})
end

return M
