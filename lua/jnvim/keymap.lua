CMD [[let mapleader = " "]]
CMD [[let maplocalleader = "\<space>"]]
CMD [[cnoreabbrev q q!]]
CMD [[cnoreabbrev Wq wq]]
CMD [[map ; :]]

MAP('i', 'jj', '<esc>')
MAP('n', 'j', 'gj')
MAP('n', 'k', 'gk')

MAP('n', '<space>/', '/<<<<<<< HEAD<cr>')

MAP({'n', 'v'}, '-', '<cmd>Neotree toggle<cr>')
MAP({'n', 'v'}, '_', '<cmd>Neotree buffers<cr>')
MAP('n', '<space><space>', '<cmd>noh<cr>')
MAP('n', '<space>c', '<cmd>lua require"funcs.telescope".find_nvim_files()<cr>')
MAP({'ie', 'te', 'n'}, '<m-e>', '<cmd>lua require"funcs.telescope".find_buffers()<cr>')
MAP({'ie',  'te', 'n'}, '<m-E>', '<cmd>lua require"funcs.telescope".find_old_files()<cr>')
MAP({'ie', 'te', 'n'}, '<m-o>', '<cmd>lua require"funcs.telescope".find_files()<cr>')
MAP({'ie', 'te', 'n'}, '<m-O>', '<cmd>lua require"funcs.telescope".find_all_files()<cr>')
MAP({'n', 'te', 'ie'}, '<c-f>', "<cmd>lua require('funcs.telescope').find_in_project()<cr>")
MAP({'ie', 'n'}, '<m-w>', '<cmd>bd<cr>')
MAP({'ie', 'n'}, '<m-b>', '<cmd>bp|bd #<cr>')
MAP({'ie', 'n'}, '<m-s>', '<cmd>w!<cr><cmd>lua print("File saved!")<cr>')
MAP({'i', 'n', 't', 'v'}, '<m-+>', '<cmd>vertical resize +5<cr>')
MAP({'i', 'n', 't', 'v'}, '<m-_>', '<cmd>vertical resize -5<cr>')
MAP('n', '<c-j>', '<c-w><c-j>')
MAP('n', '<c-k>', '<c-w><c-k>')
MAP('n', '<c-l>', '<c-w><c-l>')
MAP('n', '<c-h>', '<c-w><c-h>')
MAP('n', 'cp', '<cmd>let @+=expand("%")<cr>')
MAP('n', 'cf', '<cmd>let @+=expand("%:t")<cr>')
MAP('n', 'cd', '<cmd>let @+=expand("%:p:h")<cr>')
-- MAP({'i', 'n', 't', 'v'}, '<m-|>', '<cmd>StripWhitespace<cr>')
-- MAP({'i', 'n', 't', 'v'}, '<m-\\>', '<cmd>StripWhitespaceOnChangedLines<cr>')
MAP({'i', 'n', 't', 'v'}, '<m-|>', '<cmd>StripWhitespaceOnChangedLines<cr>')
MAP({'i'}, '<s-del>', '<del>')
MAP({'n', 'v'}, '<space>r', ':e<cr><cmd>lua print("File refreshed!")<cr>')

MAP({'ie', 'n'}, '<m-s>', '<cmd>w!<cr><cmd>lua print("File saved!")<cr>')
MAP('n', '<space>s', '<cmd>lua require("funcs.telescope").session_manager()<cr>')

EXEC [[
    imap <expr> <c-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <c-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <c-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
		smap <expr> <c-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
		map <MiddleMouse> <Nop>
		map <2-MiddleMouse> <Nop>
		map <3-MiddleMouse> <Nop>
		map <4-MiddleMouse> <Nop>

		imap <MiddleMouse> <Nop>
		imap <2-MiddleMouse> <Nop>
		imap <3-MiddleMouse> <Nop>
	imap <4-MiddleMouse> <Nop>
]]
