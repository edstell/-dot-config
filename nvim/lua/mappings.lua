-- Helper options for key mappings
local opts = { noremap = true, silent = true }

-- Set leader key to comma
vim.g.mapleader = ","

-- Jump to next and previous errors
vim.api.nvim_set_keymap('n', '<C-n>', ':cnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-m>', ':cprevious<CR>', opts)

-- Visual linewise up and down by default
vim.api.nvim_set_keymap('n', '<Up>', 'gk', opts)
vim.api.nvim_set_keymap('n', '<Down>', 'gj', opts)
vim.api.nvim_set_keymap('n', 'j', 'gj', opts)
vim.api.nvim_set_keymap('n', 'k', 'gk', opts)

-- Search mappings: Center search results on screen
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- Act like D and C for 'Y' command
vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

-- Use <c-space> to trigger completion (in Insert mode)
vim.api.nvim_set_keymap('i', '<silent><expr> <c-space>', 'coc#refresh()', { noremap = true, silent = true, expr = true })

-- Use `[c` and `]c` to navigate diagnostics
vim.api.nvim_set_keymap('n', '[c', '<Plug>(coc-diagnostic-prev)', opts)
vim.api.nvim_set_keymap('n', ']c', '<Plug>(coc-diagnostic-next)', opts)

-- Remap keys for Go-related actions
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', opts)
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', opts)
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', opts)
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', opts)

-- Function to show documentation
local function show_documentation()
  if vim.fn.index(vim.api.nvim_list_wins(), vim.api.nvim_get_current_win()) ~= -1 then
    vim.cmd('CocActionAsync documentation')
  end
end

-- Map U to show documentation
vim.api.nvim_set_keymap('n', 'U', ':lua show_documentation()<CR>', opts)

-- Remap for rename current word
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', opts)

-- Remap for format selected region
vim.api.nvim_set_keymap('v', '<leader>f', '<Plug>(coc-format-selected)', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', opts)

-- Show all diagnostics
vim.api.nvim_set_keymap('n', '<space>a', ':<C-u>CocList diagnostics<cr>', opts)

-- Manage extensions
vim.api.nvim_set_keymap('n', '<space>e', ':<C-u>CocList extensions<cr>', opts)

-- Show commands
vim.api.nvim_set_keymap('n', '<space>c', ':<C-u>CocList commands<cr>', opts)

-- Find symbol of current document
vim.api.nvim_set_keymap('n', '<space>o', ':<C-u>CocList outline<cr>', opts)

-- Search workspace symbols
vim.api.nvim_set_keymap('n', '<space>s', ':<C-u>CocList -I symbols<cr>', opts)

-- Do default action for next item
vim.api.nvim_set_keymap('n', '<space>j', ':<C-u>CocNext<CR>', opts)

-- Do default action for previous item
vim.api.nvim_set_keymap('n', '<space>k', ':<C-u>CocPrev<CR>', opts)

-- Resume latest coc list
vim.api.nvim_set_keymap('n', '<space>p', ':<C-u>CocListResume<CR>', opts)

-- Use tab for trigger completion with characters ahead and navigate
vim.api.nvim_set_keymap('i', '<silent><expr> <TAB>', [[pumvisible() ? "\<C-n>" : check_back_space() ? "\<TAB>" : coc#refresh()]], { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<expr><S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<C-h>"', { noremap = true, expr = true })

-- Custom function to handle Go build or test
local function build_go_files()
  local file = vim.fn.expand('%')
  if file:match('^.+_test.go$') then
    vim.cmd('GoTest')
  elseif file:match('^.+%.go$') then
    vim.cmd('GoBuild')
  end
end

-- Map the Go build/test function
vim.api.nvim_set_keymap('n', '<leader>b', '', {
  noremap = true,
  callback = build_go_files,
  silent = true
})

-- Define Go-related key mappings
vim.api.nvim_set_keymap('n', '<leader>t', '<Plug>(go-test)', opts)
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(go-run)', opts)
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(go-doc)', opts)
vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>(go-coverage-toggle)', opts)
vim.api.nvim_set_keymap('n', '<leader>i', '<Plug>(go-info)', opts)
vim.api.nvim_set_keymap('n', '<leader>l', '<Plug>(go-metalinter)', opts)
vim.api.nvim_set_keymap('n', '<leader>v', '<Plug>(go-def-vertical)', opts)
vim.api.nvim_set_keymap('n', '<leader>s', '<Plug>(go-def-split)', opts)

-- Define filetype-specific autocommands
vim.cmd([[
  augroup go
    autocmd!
    autocmd FileType go nmap <leader>b :lua require('mappings').build_go_files()<CR>
    autocmd FileType go nmap <leader>t <Plug>(go-test)
    autocmd FileType go nmap <leader>r <Plug>(go-run)
    autocmd FileType go nmap <leader>d <Plug>(go-doc)
    autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <leader>i <Plug>(go-info)
    autocmd FileType go nmap <leader>l <Plug>(go-metalinter)
    autocmd FileType go nmap <leader>v <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>s <Plug>(go-def-split)
    autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
  augroup END

  autocmd BufNewFile,BufRead *.gotmpl setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.proto setlocal expandtab tabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.prototmpl setlocal expandtab tabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.sql setlocal expandtab tabstop=2 shiftwidth=2
]])

-- Function to check for backspace in Insert mode
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Map for Proto definition
vim.api.nvim_set_keymap('n', '<leader>gpd', '<cmd>Protodef<cr>', opts)

-- Vsnip mappings
vim.api.nvim_set_keymap('i', '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], { noremap = true, silent = true, expr = true })

-- Default key mappings for buffer navigation and actions
vim.api.nvim_set_keymap('n', '<leader>h', ':noh<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>x', ':x<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', ':Explore<CR>', opts)

-- Map to toggle file explorer
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', opts)

-- Map to save file with root permission
vim.api.nvim_set_keymap('n', '<leader>ws', ':w !sudo tee % >/dev/null<CR>', opts)

