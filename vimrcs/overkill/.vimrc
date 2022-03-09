set textwidth=80
set tabstop=4
set shiftwidth=4
set autoindent

set number
set pastetoggle=<F2>
set shiftwidth=4		" sets tabs in visual mode tabbing
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set visualbell 			" to disable sounds
set t_vb= 				
set selection=exclusive
"Opens vim at last edited line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" search function in insertmode
"inoremap <C-F> <ESC>/
"nnoremap <C-F> /
"vnoremap <C-F> y/<C-R>"<CR>
inoremap <C-F> <ESC>:noh<CR>/
nnoremap <C-F> :noh<CR>/
vnoremap <C-F> y/<C-R>"<CR>
" sets ctrl-c to copying text in visual mode
vnoremap <C-C> yi
" WARNING: DON't REMAP C-C due to it stopping errors
vnoremap i <ESC>i
vnoremap v <C-V>
" sets ctrl-v to pasting the current buffer for normal and insert mode, always ends in insert mode
inoremap <C-V> <ESC>gpi
nnoremap <C-V> gpi
" to paste over highlighted text
vnoremap <C-V> pi<RIGHT>
" TODO: make backspace over highlighted text: must not save deleted lines to buffer, must keep old buffer contents"
"vnoremap <BS> <blackholedelete>
" sets ctrl-up/down in insert/normal mode to move single line up or down. always ends in insert mode
inoremap <C-UP> <ESC>:m .-2<CR>==i
inoremap <C-DOWN> <ESC>:m .+1<CR>==i
nnoremap <C-UP> :m .-2<CR>==i
nnoremap <C-DOWN> :m .+1<CR>==i
" sets ctrl-up/down in visual mode to move all lines highlighted up/down
vnoremap <C-UP> :m '<-2<CR>gv=gv
vnoremap <C-DOWN> :m '>+1<CR>gv=gv
" sets C-Left and C-Right to moving the selected text to the side
vnoremap <C-RIGHT> dp`[v`]<RIGHT>
vnoremap <C-LEFT> dhhp`[v`]<RIGHT>
" sets ctrl-x to cut the entire line. Cursor will spawn at the end of the original cutted line
"inoremap <C-X> <END><ESC>v<UP><END>di<DOWN><END>
inoremap <C-X> <ESC>v<S-V>di
vnoremap <C-X> d
nnoremap <C-X> <END>v<UP><END>di<DOWN><END>
" sets ctr-l to copying the entire line
inoremap <C-L> <ESC>mav<S-V>y`a<RIGHT>i
" helps for highlighting stuff:
	" arrows
inoremap <S-LEFT> <ESC>lv
nnoremap <S-LEFT> i<ESC>v
vnoremap <S-LEFT> h
inoremap <S-RIGHT> <ESC>lvl
nnoremap <S-RIGHT> vl
vnoremap <S-RIGHT> l
inoremap <S-UP> <ESC>v<UP>
nnoremap <S-UP> i<ESC>v<UP>
vnoremap <S-UP> <UP> 
inoremap <S-DOWN> <ESC>v<DOWN>
nnoremap <S-DOWN> v<DOWN>
vnoremap <S-DOWN> <DOWN>
	" other
inoremap <S-HOME> <ESC>v<HOME>
inoremap <S-END> <ESC>lv<END>
" tabbing highlighted text
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
inoremap <S-TAB> <BS>
" scrolling up or down>
inoremap <A-UP> <ESC><C-Y>i<RIGHT>
inoremap <A-DOWN> <ESC><C-E>i<RIGHT>
nnoremap <A-UP> <C-Y>i
nnoremap <A-DOWN> <C-E>i

inoremap <A-LEFT> <ESC>6<UP>i<RIGHT>
inoremap <A-RIGHT> <ESC>6<DOWN>i<RIGHT>
nnoremap <A-LEFT> 6<UP>i
nnoremap <A-RIGHT> 6<DOWN>i

" sets basic undo and redo mappings to what we're used to
inoremap <C-Z> <Esc>ui
inoremap <C-Y> <Esc><C-R>li
nnoremap <C-Z> ui
vnoremap <C-Z> <ESC>u
" sets ctrl-w what we're used to as ctrl-s in all modes
"nnoremap <C-W> :w<CR>
"vnoremap <C-W> <ESC>:w<CR>hi
inoremap <C-W> <ESC>:w<CR>hi
" sets ctrl-e to saving and exiting the file
inoremap <C-E> <ESC>:wq<CR>
nnoremap <C-E> :wq<CR>
" when in normal mode to edit something, go to insert mode for del, bs, enter, end, home etc
  " WARNING: only do the following in nnoremap. too dangerous in others such as visual mode
nnoremap <BS> i<BS>
vnoremap <BS> <ESC>i<BS>
nnoremap <END> i<END>
nnoremap <HOME> i<HOME>
"nnoremap <DEL> i<DEL>
nnoremap <CR> i<CR>
" When at end of line in normal mode and press arrow right, go t oinsert mode and go right
nnoremap <expr> <RIGHT> <sid>curs_ln_end() ? '<RIGHT>' : 'i<RIGHT>'
inoremap <expr> <C-_> <sid>filetype_comment()
function! s:filetype_comment() abort
	let getline = getline('.')
	let ft = &filetype
	"echom "with tab = " . getline
	let tabless = substitute(getline, '[\t]', '\1', 'g')
	"echom "without tab = " . tabless

	let occurrences = strlen(substitute(getline, "[^\t]", "","g"))
	let added_tabs = ""
	for i in range(occurrences)
		let added_tabs = added_tabs . "\<TAB>"
	endfor
	" for c
	if ft == "c" || ft == "java" 
		" TODO: make comment based on the filetype
		if strlen(tabless) == 0
			return "/**/\<LEFT>\<LEFT>"
		endif
		
		if stridx(getline, '/*') != -1 && stridx(getline, '*/') != -1 
			" remove comment from line
			"return "\<ESC>\<RIGHT>mai\<END>\<BS>\<BS>\<HOME>\<C-RIGHT>\<DEL>\<DEL>\<ESC>`ai"
			" remove comments from tabless
			"echom "tabless before = " .tabless
			let tabless = substitute(tabless, '\/\*', '', '')
			let tabless = substitute(tabless, '\*\/', '', '')
			"echom "tabless after = " .tabless
			"return "\<ESC>\<RIGHT>ma\<HOME>v\<END>\<LEFT>di" .added_tabs.tabless. "\<ESC>`ai"
			return "\<ESC>\<RIGHT>ma\<HOME>v\<END>di" .added_tabs.tabless. "\<ESC>`ai"
		else "add comment to line
			" then line has doesn't have comment
			"echom 1
			"return "\<ESC>\<RIGHT>ma\<HOME>v\<END>\<LEFT>di".added_tabs."/*".tabless."*/\<ESC>`ai"
			return "\<ESC>\<RIGHT>ma\<HOME>v\<END>\di".added_tabs."/*".tabless."*/\<ESC>`ai"
		endif
	elseif ft == "vim" || ft == "python"
		if strlen(tabless) == 0
			return "#"
		elseif stridx(getline, '#') != -1 
			"remove comment from line
			" remove comment from line
			"echom "tabless = |" . tabless ."|"
			let tabless = tabless[1:]
			"echom "tabless = |" . tabless ."|"
			return "\<ESC>\<RIGHT>ma\<HOME>v\<END>di" .added_tabs.tabless. "\<ESC>`ai"
		else 
			"add comment to line
			return "\<ESC>\<RIGHT>ma\<HOME>v\<END>\di".added_tabs."#".tabless."\<ESC>`ai"			
		endif
		return "\<HOME>"
	elseif ft == "nasm"
	  if strlen(tabless) == 0
			return ";"
		elseif stridx(getline, ';') != -1 
			"remove comment from line
			" remove comment from line
			"echom "tabless = |" . tabless ."|"
			let tabless = tabless[1:]
			"echom "tabless = |" . tabless ."|"
			return "\<ESC>\<RIGHT>ma\<HOME>v\<END>di" .added_tabs.tabless. "\<ESC>`ai"
		else 
			"add comment to line
			return "\<ESC>\<RIGHT>ma\<HOME>v\<END>\di".added_tabs.";".tabless."\<ESC>`ai"			
		endif
		return "\<HOME>"
	endif
	return ''
	
	"TODO: make comment based on the filetype
	" find comment based on filetype
	"let comments_dict = {'python': '#'}
	"if !has_key(comments_dict, ft)
	"	return ''
	"endif
	" else we have key so we add comment
	"let comment = comments_dict[ft]
	" add comment at start of line
	"return "\<ESC>\<RIGHT>ma\<HOME>" . comment . "\<SPACE>`a"
endfunction
" sets ctrl-/ while in visual mode to wrapping the highlighted text in comments
vnoremap <C-_> xi/**/<Esc><LEFT>Pi
"
"_______________________________________AUTO_COMPLETION________________________________________
" press tab and it will autocomplet the word you are currently typing.
" If there are more than one word you could be typing, it brings up more options
" If it sees that you are not typing a word, it will just be normal 'TAB'
function! s:tab_smart_complete()
	let line = getline('.')                         " current line
	let substr = strpart(line, -1, col('.')+1)      " from the start of the current line to one character right of the cursor
	let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
	if (strlen(substr)==0 || strlen(substr)==1)     " nothing to match on empty string
		return "\<tab>"
	endif
	" check for statement completion
	let ft = &filetype
	if ft == "c" || ft == "vim" || ft == "h"
		"echom "substr == |".substr."|"
		if substr == "for"
			return " (i = 0; i < N; i++) {\<CR>}\<Esc>O\<TAB>\<Esc>k$8hs"
		elseif substr[0:2] == "for"
			let i = substr[3:]
			if strlen(i) == 1
				return "\<BS> (".i." = 0; ".i." < N; ".i."++) {\<CR>}\<Esc>O\<TAB>\<Esc>k$8hs"
			endif
			let goback = string(strlen(i) +7)
			let backspace = "\<ESC>d".string(strlen(i)-1)."\<LEFT>i\<RIGHT>\<BS>"
			return backspace." (".i." = 0; ".i." < N; ".i."++) {\<CR>}\<Esc>O\<TAB>\<Esc>k$".goback."hs"
		elseif substr == "if" || substr == "while"
			return " (N) {\<CR>}\<ESC>O\<TAB>\<ESC>k$3hs"
		elseif substr == "main"
			let part1 = "\<ESC>3dhdli#include <stdio.h>\<CR>#include <stdlib.h>\<CR>\<CR>"
			let part2 = "int main(int argc, char *argv[])\<CR>{\<CR>}\<Esc>O\<TAB>return EXIT_SUCCESS;\<ESC>O"
			return part1 . part2
		elseif substr[0:5] == "switch"
			let num = 1
			let backspace = ""
			
			if strlen(substr) > 6
				let numstr = substr[6:]
				for i in range(strlen(numstr))
					let backspace = backspace . "\<BS>"
				endfor
				let num = str2nr(numstr)
			endif
			
			let s = backspace . " () {\<ENTER>\<TAB>case a:\<ENTER>\<TAB>break;"
			let abc = 98
			let up = 5
			for i in range(num-1)
				let c = nr2char(abc)
				let s = s . "\<ENTER>\<BS>case ".c.":\<ENTER>\<TAB>break;"
				let abc = abc +1
				let up = up + 2
			endfor
			let s = s."\<ENTER>\<BS>default:\<ENTER>\<TAB>break;"
			let s = s."\<ENTER>\<BS>\<BS>}"
			for go_up in range(up)
				let s = s."\<UP>"
			endfor
			let s = s."\<END>\<LEFT>\<LEFT>\<LEFT>"
			return s


		elseif substr[-2:-1] == "()"	
			if strlen(substr) > 1
				let func_name = substr[:-2]
				"look for function params somewhere
				let all_files = split(glob("./*"), "\n")
				for each_file in all_files
					"if match(each_file, ".c") == -1 && match(each_file, ".h") == -1
					"	continue
					"endif
					let all_lines = readfile(each_file)
					let boolio = ""
					for each_line in all_lines
						if boolio != ""
							if each_line == "{"
								" check in bool for parameters
								let open_brace = match(boolio, "(")
								let close_brace = match(boolio, ")")
								if open_brace != -1 && close_brace != -1
									return boolio[open_brace+1:close_brace-1]
								endif
							endif
							let boolio = ""
						elseif each_line =~ func_name
							let boolio = each_line
						endif
					endfor
				endfor
			endif
		endif
	elseif ft == "python"
		if substr == "for" 
			return " item in N:\<CR>\<TAB>\<ESC>k$hs"
		elseif substr == "main"
			let part1 = "\<HOME>def \<END>():\<CR>\<TAB>\<CR>\<CR>\<BS>"
			let part2 = "if __name__ == \"__main__\":\<CR>\<TAB>main()\<ESC>3ki\<RIGHT>"
			return part1 . part2
		endif
	elseif ft == "nasm"
		if substr == "main"
			let part0 = "\<ESC>O; params\<CR>%define x \<TAB>\<TAB>[ebp + 8]\<CR>"
			let part1 = "; values\<CR>%define i \<TAB>\<TAB>[ebp - 4]\<DOWN>"
		    let part2 = ":\<CR>  push  ebp\<CR>mov \<TAB>ebp, esp\<CR>\<CR>\<CR>\<CR>"
			let part3 = "\<BS>\<BS>.end:\<CR>  mov \<TAB>esp, ebp\<CR>pop"
			let part4 = " \<TAB>ebp\<CR>ret\<UP>\<UP>\<UP>\<UP>\<UP>  "
			return part0 . part1 . part2 . part3 . part4
		endif
	endif
	let has_period = match(substr, '\.') != -1      " position of period, if any
	let has_slash = match(substr, '\/') != -1       " position of slash, if any
	if (!has_period && !has_slash)
		return "\<C-X>\<C-P>"                         " existing text matching
	elseif ( has_slash )
		return "\<C-X>\<C-F>"                         " file matching
	else
		return "\<C-X>\<C-O>"                         " plugin matching
	endif
endfunction
inoremap <expr> <tab> <sid>tab_smart_complete()
"_______________________________________HELPER_FUNCTIONS________________________________________"
" curs_char() returns the current character the cursor is on
	" getline('.') gets the current line as a string. 
	" the split part makes the string into an array of characters. 
	" col gets the column number of the cursor (index starts at 1, not 0, thus we have the -1 at the end)
	" 's:' says that this function can be called in other functions in this [s]cript
	" '!' sets to ignore any keybindings of vimrc, useful for universalness. 
function! s:curs_char() abort 
	return split((getline('.') . " "), '\zs')[col('.')-1]
endfunction
" converts the given string to a list
function! s:str_list(stringy) abort
	return split(a:stringy, '\zs')
endfunction
" tells us whether the cursor is at the end of the line
function! s:curs_ln_end() abort
	return strlen(getline('.')) != col('.')
endfunction
" checks whether a given brace is an opening brace
function! s:is_opening_brace(brace) abort
	return a:brace == '[' || a:brace == '('
endfunction
" gets the open brace of the given brace
function! s:get_opening_brace(brace) abort
	if a:brace == '[' || a:brace == ']'
		return '['
	endif
	return '('
endfunction
" gets the closing brace of the given brace
function! s:get_closing_brace(brace) abort
	if a:brace == '[' || a:brace == ']'
		return ']'
	endif
	return ')'
endfunction
"________________________________________OPEN_BRACE_COMPLETION________________________________________"
" autocompletes open
inoremap <expr> [ <sid>autocomplete_open_brace('[') ? '[]<LEFT>' : '['
inoremap <expr> ( <sid>autocomplete_open_brace('(') ? '()<LEFT>' : '('
function! s:autocomplete_open_brace(brace) abort
	let line = split(getline('.'), '\zs')
	let length = len(line)
	let cursdex = col('.')-1
	let opening_brace = a:brace
	let closing_brace = s:get_closing_brace(opening_brace)
	" create depth array
	let depth_arr = []
	let depth = 0
	let most_negative_number_before_cursdex = 0
	let most_negative_number = 0
	for index in range(length)
		let character = line[index]
		if character == opening_brace
			let depth += 1
		elseif character == closing_brace
			let depth -= 1
		endif
		let depth_arr += [depth]
		if index < cursdex
			let most_negative_number_before_cursdex = min([most_negative_number_before_cursdex, depth])
		endif
		let most_negative_number = min([most_negative_number, depth])
	endfor
	" check if contains a number less than 0. if so, then we likely shouldn't add a completing brace
	if most_negative_number < 0
		let to_add = abs(most_negative_number_before_cursdex)
		for index in range(cursdex+1, length-1)
			echom "index = " . index
			if depth_arr[index] + to_add < 0
				return 0 " don't autocomplete brace
			endif
		endfor
	endif
	return 1 " do autocomplete the brace
endfunction
"________________________________________CLOSE_BRACE_COMPLETION________________________________________
" makes sure close braces have friends
inoremap <expr> ) <sid>add_close_brace(')') ? ')' : '<RIGHT>'
inoremap <expr> ] <sid>add_close_brace(']') ? ']' : '<RIGHT>'
function! s:add_close_brace(brace) abort
	" first check if cursor resting on a brace
	let curs_char = s:curs_char()
	if curs_char != ']' && curs_char != ')'
	 	return 1 " if user is not on a brace, we don't care	-> add brace
	endif
	" check if creating the given brace will have a buddy if created
	let line = split(getline('.') . " ", '\zs')
	let length = len(line)
	let cursdex = col('.')-1
	let closing_brace = a:brace
	let opening_brace = s:get_opening_brace(closing_brace)
	" create depth array
	let depth_arr = []
	let depth = 0
	let most_negative_number_before_cursdex = 0
	let most_negative_number = 0
	for index in range(length)
		let character = line[index]
		if character == opening_brace
			let depth += 1
		elseif character == closing_brace
			let depth -= 1
		endif
		let depth_arr += [depth]
		if index < cursdex
			let most_negative_number_before_cursdex = min([most_negative_number_before_cursdex, depth])
		endif
		let most_negative_number = min([most_negative_number, depth])
	endfor
	" to_add = number to add to final number to make the most negative number = 0
	let to_add = 0
	if most_negative_number < 0
		let to_add = abs(most_negative_number_before_cursdex)
	endif
echom string(depth_arr)
	" if last depth (equalized by summing to_add) > 0, then adding closing brace will be beneficial
	if depth_arr[-1] + to_add > 0
		echom "add brace: " . depth_arr[-1] . " > 0"
		return 1 " do add a brace
	else
		echom "don't add brace: " . depth_arr[-1] . " <= 0"
		return 0 " don't add a brace
	endif
	return 1 " do add a closing brace
endfunction
"________________________________________BRACE_DELETION________________________________________
" if backspace on brace, must check if brace has a friend. if so -> remove self and friend
inoremap <BS> <c-r>=BS_Brace()<CR>
function! BS_Brace() abort	
	let pc = col('.')-2
	"pc = pre_cursor index, the index before the cursor
	if pc == -1
		return "\<BS>"
	endif
	let line = getline('.') . " " 
	let pre_curs = split(line, '\zs')[pc]
	if index(['[', ']', '(', ')'], pre_curs) >= 0
		" search for this bracket's mate
		let closing_brace = (pre_curs == '[' || pre_curs == ']') ? ']' : ')'
		let opening_brace = closing_brace == ']' ? '[' : '('
		let mate = pre_curs == closing_brace ? opening_brace : closing_brace
		let mate_index = s:seek_mate(pc, mate, line)
		" if not -1, mate exists and thus we must remove it
		if mate_index != -1
			" get start and end indices 
			let start = min([mate_index, pc])
			let end = start == pc ? mate_index : pc
			" construct str: the line removing those braces
			let p1 = start == 0 ? '' : line[:start-1]
			let p2 = line[start+1:end-1]
			let p3 = line[end+1:-2]
			let str = p1 ."". p2 ."". p3
			" get pos of cursor
			let pos = len(p1)
			if !s:is_opening_brace(pre_curs)
				"if pre_curs == ']' || pre_curs == ')'
				let pos += len(p2)
			endif
			if pos == 0 " if cursor/braces at start of line
				return "\<ESC>\<END>v\<HOME>xi" . str . "\<DEL>\<ESC>\<HOME>i"
			elseif pos == len(str) " if cursor/braces at end of line
				return "\<ESC>\<END>v\<HOME>xi" . str . "\<DEL>\<ESC>i\<END>"
			else " if cursor/braces anywhere inbetween
				return "\<ESC>\<END>v\<HOME>xi" . str . "\<DEL>\<ESC>\<HOME>" . (pos) . "li"
			endif
		endif
	endif
	return "\<BS>"
endfunction
" gets the index of the given brace if it exists, else returns -1. 
function! s:seek_mate(index, mate, line_string) abort
	" get the brace
	let line = s:str_list(a:line_string)
	let length = len(line)
	let brace = line[a:index]
	let closing_brace = s:get_closing_brace(brace)
	let opening_brace = s:get_opening_brace(brace)
	let depth = 0 " the depth of the wrapper: in (()(index)), index has depth 2
	if s:is_opening_brace(brace) " if is opening brace
		" look for mate to the right
		let currdex = a:index+1
		while currdex < length
			let currbrace = line[currdex]
			" if we have found the end
			if currbrace == closing_brace
				" if depth 0, we are done. else decrease depth
				if depth == 0
					" then we are done
					return currdex
				else
					" decrease depth
					let depth -= 1
				endif
			" if we found an opening brace, increase depth
			elseif currbrace == opening_brace
				let depth += 1
			endif
			let currdex += 1
		endwhile
	else " must be closing brace
		" look for mate to the left
		let currdex = a:index-1
		while currdex >= 0
			let currbrace = line[currdex]
			" if we have found and end brace, decrease depth
			if currbrace == closing_brace
				let depth -= 1
			" if we found an opening brace, increase depth
			elseif currbrace == opening_brace
				" if depth 0, we are done. else increase depth
				if depth == 0
					" then we are done
					return currdex
				else
					" increase depth
					let depth += 1
				endif
			endif
			let currdex -= 1
		endwhile
	endif
	" thus we have not found the mate
	return -1
endfunction
" if highlighted and presses wrapper, wrap selected text in wrapper
vnoremap ( xi()<Esc>Pi
vnoremap [ xi[]<Esc>Pi
" quotation mark auto complete
inoremap <expr> ' <sid>complete_apostrophe()
function! s:complete_apostrophe() abort
	" get line stuff
	let getline = getline('.')
	let pre_curs_line = strpart(getline, -1, col('.'))
	let str_list = s:str_list(pre_curs_line)
	" get boolean variables
	let even_quotation = count(str_list, "\"")%2==0
	" if in string, rule's don't apply
	if !even_quotation
		return "'"
	endif
	let even_apostrophe = count(str_list, "'")%2==0
	let on_apostrophe = s:curs_char() == "'"
	if on_apostrophe
		if even_apostrophe " then even amount of ' already, addition would messup balance
			return "'" "complete apostrophe to create balance
		else
			return "\<RIGHT>" "must be a mistake
		endif
	else "not on apostrophe: just regular typing
		if even_apostrophe " then must keep balance by adding both 
			return "''\<LEFT>"
		else " then balance must be gained
			return "'"
		endif
	endif
endfunction
set mouse=a
" adds brace stuffs
autocmd FileType c inoremap {<CR> {<CR>}<Esc>O<TAB>
autocmd FileType java inoremap {<CR> {<CR>}<Esc>O<TAB>
"autocmd FileType c inoremap {<CR> {<CR><TAB><END>;<CR><BS>}<UP><RIGHT>
" ctrl-R (ctrl-Run) maps to saving the changes and then running it in the terminal"
inoremap <expr> <C-R> <sid>save_and_run()
nnoremap <expr> <C-R> <sid>save_and_run()
function! s:save_and_run() abort
	" get filename
	let file_name = @%
	" get /home/wizard/.vimrc
	let index = strridx(file_name, "\/")
	if index != -1
		let name = strpart(file_name, index+1)
	else
		" doesn't have /
		let name = file_name
	endif
	"echom name
	let ft = &filetype
	if ft == "c"
		let name = strpart(name, 0, strlen(name)-2)
		return "\<ESC>:w\<CR>:!cc -Wall -ansi -pedantic -o ".name.".out ".name.".c -lm && ./".name.".out\<CR>"
	elseif ft == "python"
		let name = strpart(name, 0, strlen(name)-3)
		return "\<ESC>:w\<CR>:!python3 ".name.".py\<CR>"
	elseif ft == "java"
		let name = strpart(name, 0, strlen(name)-5)
		return "\<ESC>:w\<CR>:!javac ".name.".java && java ".name."\<CR>"
	elseif ft == "nasm"
		let name = strpart(name, 0, strlen(name)-4)
		let nasm = "nasm -f elf64 -o ".name.".o ".name.".asm"
		let lild = "ld ".name.".o -o ".name
		let runit = "./".name
		return "\<ESC>:w\<CR>:!".nasm." && ".lild." && ".runit."\<CR>"
	else
		return ""
	endif
endfunction
" sets <C-P> to pasting printf("",);
autocmd FileType c inoremap <C-P> printf("%s\n", );<ESC>8hi
autocmd FileType python inoremap <C-P> print("")<ESC>hi
autocmd FileType java inoremap <C-P> System.out.println("");<ESC>2hi
" sets <C-P> in visual mode to printing out the variable with printf
autocmd FileType c vnoremap <C-P> yiprintf("<END> = %s\n",  <ESC>vp<END>i<RIGHT>);<ESC>9hi
autocmd FileType python vnoremap <C-P> yiprint("<END> = " + str( <ESC>vp<END>i<RIGHT>))<LEFT>
autocmd FileType java vnoremap <C-P> yiSystem.out.println("<END> = " + <ESC>vp<END>i<RIGHT>);<ESC>9hi

" sets main-TAB to adding the entire main function
"autocmd FileType c inoremap main<TAB> #include <stdio.h><CR>#include <stdlib.h><CR><CR>int main(int argc, char *argv[]) {<CR>}<Esc>O<TAB>return EXIT_SUCCESS;<ESC>O;<LEFT>
"inoremap scanf<TAB> scanf("%s", N);<ESC>2hs
"autocmd FileType c inoremap <expr> <CR> <sid>semi_colon()
function! s:semi_colon() abort
	" check if current line ends with ;
	let getline = getline('.')
	let str_list = s:str_list(getline)
	let len = len(str_list)
	if (len == 0)
		return "\<CR>"
	endif
	if str_list[len-1] == ";" 
		let curs_char2 = split((getline('.') . " "), '\zs')[col('.')-2]
		if (s:curs_char() == ";" || curs_char2 == ";")
			let tabless = substitute(getline, '[\t]', '\1', 'g')
			if len(s:str_list(tabless)) == 1
				return "\<DEL>\<CR>"
			else
				return "\<RIGHT>\<CR>;\<LEFT>"
			endif
			return "\<CR>;\<LEFT>"
		else
			"return "\<END>\<CR>"
		endif
	endif
	return "\<CR>"
endfunction
" smart non-complete for ;
autocmd FileType c inoremap <expr> ; <sid>curs_char() == ";" ? '<RIGHT>' : ';'
" search and replace
vnoremap <C-R> :s///gc
"downwards
inoremap <C-O> <ESC>O
"upwards
inoremap <C-S-O> <ESC><S-O>
" sets Ctrl-D(efine) to defining the value upstairs
autocmd FileType c vnoremap <expr> <C-D> <sid>define_var()
function! s:define_var() abort
	" find first line that is only '{' since that marks the start of the function
	let linenumber = line('.')
	while 1
		let line = getline(''.linenumber)
		if line == "{"
			break
		endif
		let linenumber = linenumber - 1
		if linenumber == 0
			return "can't find function start bro"
		endif
	endwhile
	return "yma".linenumber."Go\<TAB>;\<ESC>hp`av\<C-RIGHT>\<LEFT>\<DEL>i\<DEL>"
endfunction
" auto create assembly
autocmd FileType nasm vnoremap <expr> <C-D> <sid>define_nasm()
function! s:define_nasm() abort
	" find first %
	let linenumber = line('.')
	let backspace = ""
	let num = 0
	while 1
		let line = getline(''.linenumber)
		if strlen(line) == 0
			let linenumber = linenumber - 1
			continue
		endif
		let str_list = s:str_list(line)
		if str_list[0] == "%"
			" get the number [ebp-12]
			let minus = stridx(line, "-")
			let close = stridx(line, "]")
			let numstr = strpart(line, minus+1, close-minus-1)
			let numlen = strlen(numstr)
			while numlen != 0
				let backspace = backspace."\<BS>"
				let numlen = numlen - 1
			endwhile
			let new_num = str2nr(numstr) + 4
			break
		endif
		let linenumber = linenumber - 1
		if linenumber == 0
			return "can't find function start bro"
		endif
	endwhile
	return "yma".linenumber."Go%define \<ESC>pi\<END> \<TAB>\<TAB>[ebp - ".new_num."]\<ESC>`ai"

endfunction

" auto define
autocmd FileType c inoremap <expr> <C-D> <sid>define_prototype()
function! s:define_prototype() abort
	" find first line that starts with # since that is the include, marks the start of the file
	let linenumber = line('.')
	let line = getline(''.(linenumber-1))
	if line != "{"
		return ""
	endif
	while 1
		let line = getline(''.linenumber)
		let str_list = s:str_list(line)
		if strlen(line) > 10 && str_list[0:7] == s:str_list("#include")
			break
		endif
		let linenumber = linenumber - 1
		if linenumber == 0
			break
		endif
	endwhile
	" we have linenumber to go to
	return "\<ESC>ddkpma".linenumber."Gpi\<END>;\<ESC>`ai"
endfunction

"set filetype plugin on
"set smartindent
"if file open, and change file in other editor, it updates the change
"set autoread
"higlights stuff like int I think
"syntax enable
"Something-something-let's you write unicode in vim
"set encoding=utf8
"use unix as standard file type...which is good (no ?mark about it)
"set ffs=unix,dos,mac
"no annoying backup stuff, hardcore mode
"set nobackup
"set nowb
"set noswapfile
"set textwidth=80
"wordy for java, good C
"set list " shows stuff lie ^I and $
"set listchars=tab:>-
"possibly good for 244
set nowrap
"You know
"sets position of new windows
set splitbelow
set splitright
au FileType alan set autoindent expandtab softtabstop=4 shiftwidth=4 tabstop=4 textwidth=80
