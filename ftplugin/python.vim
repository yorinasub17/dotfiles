if exists("b:did_ftplugin")
finish
endif

" jedi settings
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = ""

map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
