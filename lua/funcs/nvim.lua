local M = {}

M.scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function M.split_into_table(input, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(input, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

function M.reload(...)
  return require("plenary.reload").reload_module(...)
end

function M.P(v)
  print(vim.inspect(v))
  return v
end

M.R = function(name)
  M.reload(name)
  return require(name)
end

function M.mapper(mode, key, result, opts)
  if type(mode) ~= 'table' then
    mode = { mode }
  end

  for _,v in ipairs(mode) do
    if v == 'ie' then
      result = '<esc>'..result
    end
    if v == 'te' then
      result = '<c-\\><c-n>'..result
    end

    local options = {noremap = true}
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(string.sub(v, 1, 1), key, result, options)
  end
end

function M.opt(scope, key, value)
  M.scopes[scope][key] = value

  if scope ~= 'o' then
    M.scopes['o'][key] = value
  end
end

function M.opt_local(opt, value)
  if value == true then
    vim.cmd(('setlocal %s'):format(opt))
  elseif value == false then
    vim.cmd(('setlocal no%s'):format(opt))
  else
    vim.cmd(('setlocal %s=%s'):format(opt, value))
  end
end

function M.create_augroup(autocmds, name)
	vim.cmd('augroup ' .. name)
	vim.cmd('autocmd!')
	for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
	vim.cmd('augroup END')
end

function M.create_augroup_buffer(autocmds, name)
	vim.cmd('augroup ' .. name)
	vim.cmd('autocmd! * <buffer>')
	for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
	vim.cmd('augroup END')
end

function M.command(cmd)
	vim.cmd(cmd)
end

function M.exec(code)
  vim.api.nvim_exec(code, true)
end

function M.get_dir_files(dir)
	local files = {}
	local p = io.popen('find "'..dir..'" -maxdepth 1 -type f')
	for file in p:lines() do
		table.insert(files, file)
	end

	return files
end

function M.neotree_check_if_opened()
	local exists = false
	for _, buf in ipairs(vim.fn.getbufinfo()) do
		if string.find(buf.name, 'neo.tree') then
			exists = true
		end
	end
	return exists
end


function M.sessions_get_all()
	local sessions = {}
	for _, file in ipairs(M.get_dir_files(vim.fn.getcwd())) do
		if string.find(file, 'session-.+.vim') then
			local res, _ = file:match("(%w+)(.vim)$")
			table.insert(sessions, res)
		end
	end
	return sessions
end

function M.session_save(name)
	local neotree_opened = M.neotree_check_if_opened()
	if neotree_opened then
		vim.cmd [[ Neotree close ]]
	end

	local session_path = ("%s/session-%s.vim"):format(vim.fn.getcwd(), name)
  vim.cmd(('%s %s'):format("mksession!", vim.fn.fnameescape(session_path)))
	vim.notify((" Written session `%s`. "):format(name))

	if neotree_opened then
		vim.cmd [[ Neotree show ]]
	end
end

function M.session_load(name)
	local session_path = ("%s/session-%s.vim"):format(vim.fn.getcwd(), name)
	vim.cmd(('source %s'):format(vim.fn.fnameescape(session_path)))
	vim.v.this_session = session_path
	vim.notify((" Loaded session `%s`. "):format(name))
end

function M.vim_on_enter()
	 local session_load_if_exists = function()
		local sessions = M.sessions_get_all()
		if #sessions == 1 then
			M.session_load(sessions[1])
		end
	end
  vim.fn.timer_start(100, vim.schedule_wrap(session_load_if_exists))

	-- local start_neotree = function()
	-- 	vim.cmd [[ Neotree focus ]]
	-- end
	--  vim.fn.timer_start(200, vim.schedule_wrap(start_neotree))

end

return M
