----------------
--- SETTINGS ---
----------------

vim.opt.number = true		-- Show line numbers
vim.opt.showmatch = true	-- Highlight matching parenthesis	

vim.opt.ignorecase = true	-- Search case insensitive
vim.opt.smartcase = true	-- Search case sensitive when search string has upper case 


-- set cmd height 0 for less distraction
vim.opt.cmdheight = 0






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


})

