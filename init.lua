vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.splitbelow = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.opt.number = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
--[[    {
      "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        -- This command builds/updates parsers
        config = function()
          -- Optional: Configure nvim-treesitter options here
          local configs = require("nvim-treesitter.configs")
          configs.setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" }, -- Example languages to install
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
          })
      end,
    }, --]]
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    { 
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      branch = 'main',
      build = ':TSUpdate'
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
  	{
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
       lazy = false, -- neo-tree will lazily load itself
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require('lualine').setup({
          options = {
            theme = 'dracula'
          }
      })
      end
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require'nvim-treesitter'.setup {
  -- Directory to install parsers and queries to
  ensure_installed = { "c", "cpp", "rust", "lua" },
  highlight = { enable = true },
  indent = { enable = true },
  install_dir = vim.fn.stdpath('data') .. '/site'
}

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-n>', ":Neotree filesystem reveal left <CR>", {})
vim.keymap.set('n', '<C-t>', ':10split | terminal<CR>', {})
