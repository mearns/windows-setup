"This is the Linux/Unix vimrc to place in your home directory. Then checkout
"vim_rc into the same directory. This one will be loaded by Vim, but it will
"source the one under vim_rc which is where all of your options should
"actually go.
"The windows version (_vimrc) also sources this one, to keep everything in one place.

let s:this_dir = expand('<sfile>:p:h')

let s:vim_vcs_dir = s:this_dir

" exec 'set runtimepath+=' . fnameescape(s:vim_vcs_dir) . '/vimfiles'
" exec 'set runtimepath+=' . fnameescape(s:vim_vcs_dir) . '/vimfiles/after'

let s:vimrc = s:vim_vcs_dir . '/vim_rc/_vimrc'

exec 'source ' . s:vimrc

"source $VIM/vim_rc/_vimrc
" Cursor to the next lines and press CTRL-2 (CTRL-@) to edit it.
" vimex: e $VIM/vim_rc/_vimrc

"Override what we just defined to edit the real thing.
command! Vimrc source $MYVIMRC
exec 'command! EditVimrc e ' . s:vimrc
exec 'command! TabnewVimrc tabnew ' . s:vimrc
exec 'command! SplitVimrc split ' . s:vimrc
