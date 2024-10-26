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
vim.opt.expandtab = false	-- expand tabs into spaces
vim.opt.shiftwidth = 4		-- number of spaces to use for each step of indent.
vim.opt.tabstop = 4			 -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })

-- lsp mappings
local on_attach = function ()
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer=0})
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
end


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
  		"olimorris/onedarkpro.nvim",
 		priority = 1000, -- Ensure it loads first
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
				ensure_installed = {"lua_ls", "gopls", "jdtls"}
			})
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach
			})

			lspconfig.jdtls.setup({
				capabilities = capabilities,
				on_attach = on_attach
			})
		end,
	},

	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources(
					{
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
					},
					{
		 				{ name = 'buffer' },
					}
				)
			})
		end
	}

})
