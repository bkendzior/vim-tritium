" Vim indent file
" Language:	TritiumScript


if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetIndent()

function! GetIndent()
  let lnum = prevnonblank(v:lnum - 1) " the line number of the previous nonblank line
  let this_line = getline(v:lnum) " the content of the current line
  let previous_line = getline(lnum) " the content of the prev nonblank line

  " Hit the start of the file, use zero indent.
  if a:lnum == 0
    return 0
  endif

  " Note that certain special characters (like ()?/) require 3 backslashes (two
  " to escape an original backslash, one to escape the char, combined to be an
  " escaped version of the char when parsed). For clarity, more conditions are
  " written out, instead of fewer conditions but uglier lines of regex.

  if this_line =~ "^\\s*#"
    " If whole line is just a comment, normal indent
    return indent(lnum)
  else
    if this_line =~ "\}\\s*\\\(#.*\\\)\\\?\\s*$" && previous_line =~ "\{\\s*\\\(#.*\\\)\\\?\\s*$"
      " If prev is { and curr is }, normal indent [# comment version]
      return indent(lnum)
    elseif this_line =~ "\}\\s*\\\(\\\/.*\\\)\\\?\\s*$" && previous_line =~ "\{\\s*\\\(\\\/.*\\\)\\\?\\s*$"
      " If prev is { and curr is }, normal indent [// comment version]
      return indent(lnum)
    elseif this_line =~ "\}\\s*\\\(#.*\\\)\\\?\\s*$" || this_line =~ "\}\\s*\\\(\\\/.*\\\)\\\?\\s*$"
      " If curr is } but prev is not {, outdent
      return indent(lnum) - &sw
    elseif previous_line =~ "\{\\s*\\\(#.*\\\)\\\?\\s*$" || previous_line =~ "\{\\s*\\\(\\\/.*\\\)\\\?\\s*$"
      " If prev is { but curr is not {, indent
      return indent(lnum) + &sw
    else
      " Normal indent otherwise
      return indent(lnum)
    endif
  endif
endfunction
