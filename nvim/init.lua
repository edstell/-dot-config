-- ~/.config/nvim/init.lua

-- Bootstrap packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.cmd [[packadd packer.nvim]]
  end
end

ensure_packer()

require('plugins')
require('settings')
require('mappings')
require('commands')
require('lsp_config')

-- Load existing Vimscript configuration
vim.cmd('source ~/.config/nvim/old.init.vim')
