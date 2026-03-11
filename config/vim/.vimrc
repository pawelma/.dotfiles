call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'jehuipark/github-co-author-vim-plugin'
Plug 'github/copilot.vim'
Plug 'folke/tokyonight.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme tokyonight

let g:github_co_author_list_path = '~/.vim/github-co-author-list'
let g:copilot_node_command = trim(system('asdf which node'))

let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'markdown': v:true,
    \ 'yaml': v:true
    \ }
autocmd BufReadPre *
     \ let f=getfsize(expand("<afile>"))
     \ | if f > 100000 || f == -2
     \ | let b:copilot_enabled = v:false
     \ | endif
