" show line numbers
set number

" remap leader
let mapleader = ","

" Plugins will be downloaded to ~/.vim/plugged
call plug#begin()

" VimGo: lots of lovely go features for vim editing
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Molokai: a colourful theme
Plug 'fatih/molokai'

" CTRLP: for jumping between functions
Plug 'ctrlpvim/ctrlp.vim'

" Auto Pairs: insert or delete brackets, parens, quotes in pairs
Plug 'jiangmiao/auto-pairs'

" Commentary: comment out lines of code
Plug 'tpope/vim-commentary'

" Gitgutter: display git diff info
Plug 'airblade/vim-gitgutter'

" ALE: linting engine for c files
Plug 'w0rp/ale'

" Vim Clang Format: auto formatting for c family files
Plug 'rhysd/vim-clang-format'

" Automatic async autocompletion in go
Plug 'Shougo/deoplete.nvim'

call plug#end()

" write the content of the file on 'make'
set autowrite

" shortcuts for go plugin
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" all go lists are quicklists
let g:go_list_type = "quickfix"

" set go test timeout time
let g:go_test_timeout = '10s'

" run :GoBuild or GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" change go formatting binary to goimports
let g:go_fmt_command = "goimports"

" comments not included as part of the text object
" let g:go_textobj_include_function_doc = 0

" highlight types in go
let g:go_highlight_types = 1

" highlight fields in go
let g:go_highlight_fields = 1

" highlight method names in declarations
let g:go_highlight_functions = 1

" highlight method invocations
let g:go_highlight_function_calls = 1

" change tab spacing rules for go files
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" change tab spacing rules for go files
autocmd BufNewFile,BufRead *.proto setlocal noexpandtab tabstop=4 shiftwidth=4

" change tab spacing rules for go files
autocmd BufNewFile,BufRead *.c setlocal noexpandtab tabstop=4 shiftwidth=4

" enable molokai with original colour scheme and 256 colour version
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

" enable go metalinter (gofmt, golint and govet)
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

" gometalinter autosaves
let g:go_metalinter_autosave = 1

" change to only run fast ops on autosave
let g:go_metalinter_autosave_enabled = ['vet']

" cancel metalinter after 5 seconds
let g:go_metalinter_deadline = "5s"

" change GoAlternate invocation
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" change GoDef to use godef
let g:go_def_mode = 'godef'

" show info when cursor is moved
let g:go_auto_type_info = 1

" update info every 100ms
set updatetime=800

" highlight same ids in go
let g:go_auto_sameids = 1

" Search behaviour
" Ignore case when searching
set ignorecase
" Except when the search query contains a capitol letter
set smartcase

" Colour at column 80
set colorcolumn=80

" Copy to from macOS clipboard
set clipboard=unnamed

" Wrap long lines on spaces/tabs rather than the last character that first on
" the screen
set linebreak

" Bash style autocomplete
" https://stackoverflow.com/a/526940/4129860
set wildmode=longest,list,full
set wildmenu

" treat .h files as c headers
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" let vim search include files when going to a file
let &path.="src/include,/usr/include/AL,"

" transform strings in to file paths when going to a file
set includeexpr=substitute(v:fname,'\\.','/','g')

" config for clang-complete
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

" search path for files
let &path.="../lib,../include,/usr/include/AL,"

" define linters ale should use
let g:ale_linters = {'c': ['clang','clangd']}

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 0

" Enable ale only for c
let g:ale_pattern_options = {
\   '.*\.c$': {'ale_enabled': 1},
\   '.*\.h$': {'ale_enabled': 1},
\}

" clang format styling options
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : 4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
