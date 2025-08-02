require("core.keymaps")
require("core.plugins")
require("core.plugin_config")

vim.opt.splitbelow = true

vim.keymap.set('n', '<c-t>', ':10split | terminal<CR>')
