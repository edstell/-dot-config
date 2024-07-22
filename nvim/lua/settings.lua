-- General Settings
vim.opt.compatible = false -- This line can be omitted; Neovim is non-compatible by default
vim.opt.ttyfast = true
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.laststatus = 2
vim.opt.encoding = 'utf-8'
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.errorbells = false
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autowrite = true
vim.opt.hidden = true
vim.opt.fileformats = {'unix', 'dos', 'mac'}
vim.opt.showmatch = false
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = {'menu', 'menuone'}
vim.opt.pumheight = 10
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.lazyredraw = true
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.wrap = false
vim.opt.shell = '/bin/zsh'

-- Clipboard
if vim.fn.has('unnamedplus') == 1 then
  vim.opt.clipboard:append('unnamed')
  vim.opt.clipboard:append('unnamedplus')
end

-- Undo settings
if vim.fn.has('persistent_undo') == 1 then
  vim.opt.undofile = true
  vim.opt.undodir = vim.fn.stdpath('config') .. '/tmp/undo'
end

-- Colourscheme
vim.cmd('syntax enable')
vim.g.rehash256 = 1
vim.g.molokai_original = 1
vim.cmd('colorscheme gruvbox')

-- NERDTree settings
vim.g.NERDTreeShowHidden = 1

-- Airline settings
vim.g.airline_powerline_fonts = 0

-- Prettier settings
vim.g.prettier_autoformat_require_pragma = 0

-- File browsing settings
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = ',\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

-- vim-go settings
vim.g.go_fmt_command = "goimports"
vim.g.go_autodetect_gopath = 1
vim.g.go_list_type = "quickfix"
vim.g.go_test_show_name = 1
vim.g.go_auto_sameids = 0
vim.g.go_gopls_enabled = 0
vim.g.go_def_mapping_enabled = 0

vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_operators = 1

-- Vsnip settings
vim.g.vsnip_jump_forward = '<Plug>(vsnip-jump-next)'
vim.g.vsnip_jump_backward = '<Plug>(vsnip-jump-prev)'

