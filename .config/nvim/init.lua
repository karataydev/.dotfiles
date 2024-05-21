----------------
--- SETTINGS ---
----------------

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true 	-- Enable 24-bit RGB colors

-- This comes first, because we have mappings that depend on leader
-- With a map leader it's possible to do extra key combinations
vim.g.mapleader = ','

vim.opt.number = true		-- Show line numbers
vim.opt.showmatch = true	-- Highlight matching parenthesis	

vim.opt.ignorecase = true	-- Search case insensitive
vim.opt.smartcase = true	-- Search case sensitive when search string has upper case 

vim.opt.cmdheight = 0		-- cmdheight to hide cmd for less distraction


-- tab options, I will try to use tabs
vim.opt.expandtab = false  -- expand tabs into spaces
vim.opt.shiftwidth = 4    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 4       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })


-- lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


----------------
--- PLUGINS ---
----------------

require("lazy").setup({

  -- colorscheme
  {
    "Yazeed1s/oh-lucy.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function ()
      vim.cmd([[colorscheme oh-lucy]])
    end,
  },

  -- nvim tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- which key helper
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
	"neovim/nvim-lspconfig",
	dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
  	},
	config = function()
	  local lspconfig = require("lspconfig")
	  require("mason").setup()
	  require("mason-lspconfig").setup({
	    ensure_installed = {"lua_ls", "gopls"}
	  })
	  lspconfig.lua_ls.setup({
		settings = {
		  Lua = {
		    diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
		  },
		},
	  })
	  lspconfig.gopls.setup({})
	end,
  }

})
