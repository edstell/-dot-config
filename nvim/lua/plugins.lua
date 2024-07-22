-- Plugin management with packer
require('packer').startup(function()
  use 'fatih/vim-go'
  use 'morhetz/gruvbox'
  use 'ctrlpvim/ctrlp.vim'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-commentary'
  use 'jiangmiao/auto-pairs'
  use 'preservim/nerdtree'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'HerringtonDarkholme/yats.vim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use {
    'prettier/vim-prettier',
    run = 'yarn install --frozen-lockfile --production',
    ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}
  }
  use 'sheerun/vim-polyglot'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
end)
