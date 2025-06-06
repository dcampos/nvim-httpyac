if exists('b:did_ftplugin')
    finish
endif

let b:did_ftplugin = 1
let b:undo_ftplugin = 'setl foldmethod< foldexpr<'

function! HttpResultFold(lnum)
    if getline(a:lnum) =~ '%PDF-'
        return '>1'
    elseif getline(a:lnum) =~ '%%EOF'
        return '<1'
    elseif foldlevel(a:lnum -1) > 0
        return '='
    endif
    return 0
endfunction

setlocal foldmethod=expr foldexpr=HttpResultFold(v:lnum)
