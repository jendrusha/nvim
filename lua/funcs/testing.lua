local M = {}

function M.setup()
	EXEC [[
	function! GoVimTestTransform(cmd) abort
		let l:cwd = getcwd()
		let l:cmd = escape(a:cmd, '^$.*?/\[]')

		if stridx(l:cwd, "everphone/everphone/iamservice") != -1
			return 'docker-compose exec -e ENV=test -e GIN_MODE=test -T iamservice '. l:cmd
		endif

		if stridx(l:cwd, "everphone/everphone") != -1
			return 'docker-compose exec -e ENV=test -e GIN_MODE=test -T publicbox '. l:cmd
		endif

		return escape(a:cmd, '^$.*?/\[]')
	endfunction
	]]

	vim.g["test#custom_transformations"] = {godocker = vim.fn["GoVimTestTransform"]}
	vim.g["test#transformation"] = "godocker"
	vim.g["test#neovim#term_position"]= "vert"
	vim.g["test#strategy"] = "neovim"
end

return M
