local welcome = "Hello from ~/.config/nvim/init.lua"
print(welcome)
require("beths.vim-key-remap")
-- This will load ./lua/beths/vim-key-remap.lua or ./lua/beths/vim-key-remap/init.lua

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

-- Setup lazy.nvim
--require("lazy").setup("plugins")
-- This will load ./lua/plugins.lua and ./lua/plugins/*.lua
require("lazy").setup({
  spec = { { import = "plugins" } },
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight-night" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("beths.vim-plugin-useage")
-- This will load ./lua/beths/vim-plugin-useage.lua or ./lua/beths/vim-plugin-useage/init.lua
