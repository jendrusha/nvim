local eslint = require 'diagnosticls-configs.linters.eslint'
local prettier = require 'diagnosticls-configs.formatters.prettier'
local phpstan = require 'diagnosticls-configs.linters.phpstan'
return {
  ['javascript'] = {
    linter = eslint,
    formatter = prettier
  },
  ['php'] = {
    linter = phpstan,
  },
}
