"============================================================================
"File:        localindent.vim
"Description: vim plugin to load per folder/repository settings
"============================================================================

if exists("g:loaded_localindent_plugin")
    finish
endif
let g:loaded_localindent_plugin = 1

function! localindent#set_buffer(buffer_id) abort
    let s:buffer_id = a:buffer_id
    let s:file = resolve(bufname(a:buffer_id))
endfunction

function! localindent#directory_of_file() abort
    return fnamemodify(s:file, ':h')
endfunction

function! localindent#exec_in_dir_of_file(cmd) abort
    return 'cd '.shellescape(localindent#directory_of_file()).' && '.a:cmd
endfunction

function! localindent#is_buffer_a_file(buffer_id) abort
    return empty(expand('#' . a:buffer_id . ':p'))
endfunction

function! localindent#exec_and_strip(cmd) abort
    return substitute(system(a:cmd), '\n$', '', '')
endfunction

function! localindent#load_localfile(buffer_id) abort
    call localindent#set_buffer(a:buffer_id)
    let cmd = g:localindent_git_executable . ' rev-parse --show-toplevel'
    let cd_and_cmd = localindent#exec_in_dir_of_file(cmd)
    let root_path = localindent#exec_and_strip(cd_and_cmd)
    let file_path = root_path . '/.git/' . g:localindent_file_name
    if empty(root_path) || !filereadable(file_path)
        return
    endif
    execute 'source '.fnameescape(file_path)
endfunction

let g:localindent_file_name = '.vimrc.local'
let g:localindent_git_executable = 'git'
if !executable(g:localindent_git_executable)
    echohl WarningMsg
    echo 'localindent: ' . 'cannot find git. Please set g:localindent_git_executable.'
    echohl None
endif

for buffer_id in tabpagebuflist()
    if localindent#is_buffer_a_file(buffer_id)
        finish
    endif
    call localindent#load_localfile(buffer_id)
endfor

" vim: set et sts=4 sw=4:
