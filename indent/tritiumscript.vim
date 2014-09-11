" Vim indent file
" Language:	TritiumScript


if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetIndent()

function! IsComment(myLine)
  let condStartCommentHash = "^\\s*#"
  let condStartCommentSlash = "^\\s*\\\/\\\/"
  return a:myLine =~ condStartCommentHash || a:myLine =~ condStartCommentSlash
endfunction

function! IsStartBrace(myLine)
  let condStartBraceHash = "\{\\s*\\\(#.*\\\)\\\?\\s*$"
  let condStartBraceSlash = "\{\\s*\\\(\\\/\\\/.*\\\)\\\?\\s*$"
  return a:myLine =~ condStartBraceHash || a:myLine =~ condStartBraceSlash
endfunction

function! IsCloseBrace(myLine)
  let condCloseBraceHash = "\}\\s*\\\(#.*\\\)\\\?\\s*$"
  let condCloseBraceSlash = "\}\\s*\\\(\\\/\\\/.*\\\)\\\?\\s*$"
  return a:myLine =~ condCloseBraceHash || a:myLine =~ condCloseBraceSlash
endfunction

function! GetIndent()
  let lnum = prevnonblank(v:lnum - 1) " the line number of the prev nonblank line
  let this_line = getline(v:lnum) " the content of the current line
  let prev_line = getline(lnum) " the content of the prev nonblank line

  " Hit the start of the file, use zero indent.
  if a:lnum == 0
    return 0
  endif

  if IsComment(this_line) && !IsComment(prev_line) && IsStartBrace(prev_line)
    " If curr is comment, prev isn't, but prev is a starting brace, indent
    return indent(lnum) + &sw
  elseif IsComment(this_line)
    " If curr is comment otherwise, normal indent
    return indent(lnum)
  elseif !IsComment(this_line) && IsComment(prev_line)
    " If curr is not comment but prev is, normal indent
    return indent(lnum)
  else
    if IsCloseBrace(this_line) && IsStartBrace(prev_line)
      " If prev is { and curr is }, normal indent
      return indent(lnum)
    elseif IsCloseBrace(this_line)
      " If curr is } but prev is not {, outdent
      return indent(lnum) - &sw
    elseif IsStartBrace(prev_line)
      " If prev is { but curr is not }, indent
      return indent(lnum) + &sw
    else
      " Normal indent otherwise
      return indent(lnum)
    endif
  endif
endfunction
