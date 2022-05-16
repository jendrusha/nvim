P = require('funcs.nvim').P
R = require('funcs.nvim').R
RELOAD = require('funcs.nvim').reload
OPT = require('funcs.nvim').opt
OPTLOCAL = require('funcs.nvim').opt_local
MAP = require('funcs.nvim').mapper
CMD = require('funcs.nvim').command
EXEC = require('funcs.nvim').exec
SPLIT_STR = require('funcs.nvim').split_into_table

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

require("jnvim"):load()

vim.notify = require("notify")
