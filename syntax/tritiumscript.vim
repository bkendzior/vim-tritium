" Vim syntax file
" Language:	TritiumScript

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'tritiumscript'
endif


" Comments
syn keyword tritiumScriptCommentTodo   TODO FIXME XXX TBD contained
syn match   tritiumScriptLineComment   "#.*" contains=tritiumScriptCommentTodo
syn match   tritiumScriptLineComment	 "//.*"

" Block comments - sync w C style comments to get all that nesting logic
syn region  tritiumScriptBlockComment   start="/\*"  end="\*/"
syn sync ccomment tritiumScriptBlockComment

" Strings - gets quite complicated; copied from JS syntax file
syn match   tritiumScriptSpecial	  "\\\d\d\d\|\\."
syn region  tritiumScriptStringD	  start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  tritiumScriptStringS	  start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  tritiumScriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

" Tritium keywords
syn keyword tritiumScriptBase           add_cookie css enable enable_for equal force force_for normalize sass
syn keyword tritiumScriptBase           inferred_content_type rewrite_cookie_domain rewrite_links rewrite_meta_refresh rewrite_to_proxy rewrite_to_upstream

syn keyword tritiumScriptDebug          deprecated dump

syn keyword tritiumScriptGlobal         asset bm concat decode64 else encode64 export log match match_not not read regexp text time var with yield

syn keyword tritiumScriptAttribute      attributes format height name optimize_image quality remove value width

syn keyword tritiumScriptNode           absolutize absolutize_srcs add_assets add_apple_touch_icons add_body_class add_canonical_tag add_class add_favicon
syn keyword tritiumScriptNode           add_ignore_domain add_mobile_javascript add_mobile_stylesheet array async_bundled_js attr attribute
syn keyword tritiumScriptNode           bundle_all_js bundle_external_js cdata clean_mobile_meta_tags clear_ignore_domain copy_here copy_to defer
syn keyword tritiumScriptNode           dup fetch filter flatten hash hide index init inject inject_at inject_after inject_at inject_before inject_bottom inject_top
syn keyword tritiumScriptNode           inner inner_text inner_wrap insert insert_after insert_at insert_before insert_bottom insert_top insert_javascript
syn keyword tritiumScriptNode           insert_javascript_after insert_javascript_at insert_javascript_before insert_javascript_bottom insert_javascript_top
syn keyword tritiumScriptNode           insert_mobile_meta_tags keep_script lateload lazyLoadImages content footer header jqm keep_only_this key
syn keyword tritiumScriptNode           move move_children_to move_here move_to name node path position relocate_scripts remove remove_attributes remove_class
syn keyword tritiumScriptNode           remove_desktop_js remove_external_scripts remove_external_styles remove_html_comments remove_internal_scripts
syn keyword tritiumScriptNode           remove_internal_styles remove_meta_tags remove_scripts remove_self_if_empty remove_text_nodes select set_all_transitions
syn keyword tritiumScriptNode           set_back_btn set_back_btn_text set_ignore_attribute set_json set_transition table_dump this unwrap
syn keyword tritiumScriptNode           ur_attribute ur_carousel ur_component ur_set ur_tabs ur_toggler wrap wrap_nonempty_text wrap_text_children wrap_together yank
" DUPES syn keyword tritiumScriptNode           append set text

syn keyword tritiumScriptText           append canonicalize_javascript_libraries capture clear combine_heads convert_encoding downcase dynamic_selection
syn keyword tritiumScriptText           elide_attributes elide_bool_attributes guess_encoding html html_doc html_fragment html_fragment_doc insert_dns_prefetch
syn keyword tritiumScriptText           length move_css_above_scripts move_css_to_head prepend protect_xmlns remove_comments replace restore_xmlns reverse
syn keyword tritiumScriptText           rewrite_js rewrite_link set trim trim_urls upcase url xml

" Treat $ and $$ selector keywords specially
syn match tritiumScriptInstruction      "\$" 
syn match tritiumScriptInstruction      "\$\$"

" TODO: variables enclosed in brackets should be captured
syn match tritiumScriptVariable         "$\h\w*" display
syn match tritiumScriptVariable         "%\h\w*" display
syn match tritiumScriptInstruction      "@\h\w*" display

syn match tritiumScriptBraces	          "[{}\[\]]"
syn match tritiumScriptParens	          "[()]" 

syn sync fromstart
syn sync maxlines=100

" Color this guy
hi def link tritiumScriptLineComment	      Comment
hi def link tritiumScriptBlockComment	      Comment
hi def link tritiumScriptCommentTodo	      Todo

hi def link tritiumScriptSpecial            Special
hi def link tritiumScriptStringD	          String
hi def link tritiumScriptStringS	          String
hi def link tritiumScriptRegexpString       String

hi def link tritiumScriptDebug              Debug
hi def link tritiumScriptBase               Define
hi def link tritiumScriptGlobal             Define

hi def link tritiumScriptNode               Operator
hi def link tritiumScriptText               Operator
hi def link tritiumScriptAttribute          Operator

hi def link tritiumScriptBraces             Function
hi def link tritiumScriptParens             Function
hi def link tritiumScriptVariable           Type
hi def link tritiumScriptInstruction        Type

" Define Type Include
"
let b:current_syntax = "tritiumscript"
if main_syntax == 'tritiumscript'
  unlet main_syntax
endif

" TODO: include HTML syntax file so that stuff works as well
" TODO: advanced - add some tritium based rules (value worked on inside attribute etc)

vim: ts=2
