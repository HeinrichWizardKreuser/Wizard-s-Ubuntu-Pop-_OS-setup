# vimstuffs
everything vim related
These are just versions of my own vimrc. Feel free to use it and any contents of my versions
#alpha
this is the main version of my vimrc

# Ctrl-F
Insert|Normal: like :/ to search stuff
# Ctrl-C
Visual: copies the highlighted text and sets you to insert mode.
# Misc visual mode remappings
i goes to insert mode
v goes to visual block mode
# Ctrl-V
Insert|Normal|Visual: pastes text and leaves you in insert mode
# Ctrl-Up / Ctrl-Down
Insert|Normal: moves the current line the cursor is in up or down
Visual: moves all of the lines highlighted up or down
# Ctrl-X
Insert|Normal: cuts entire line that the cursor is currently in
Visual: cuts all of the text highlighted
# Ctrl-L
Insert: copies the current entire line that the cursor is in
# Shift-ARROWS
Insert|Normal|Visual: Highlights in the direction of the arrow (switches to visual mode, then starts highlighting)
# Shift-HOME/END
Insert: Hightlights the text from where the cursor is to the start or end of line
# TAB
Visual: Tabs highlighted lines
# Shift-TAB
Visual: Tabs highlighted lines left
Normal: Tabs current line left
# ALT-UP/DOWN
Insert|Normal: moves cursor 6 lines up or down, replacing need for mouse scroller
# Ctrl-Z
Insert|Normal: Undoes last action and leaves you in insert mode
Visual: just undeos action
# Ctrl-Y
Insert: redos action
# Ctrl-W
Insert: writes current files(saves file, basically same as Ctrl-S in most editors, :w)
# Ctrl-E
Saves and exits
# Backspace
Normal|Visual: goes to insert mode and backspaces
# HOME/END/ENTER
Normal: Does the action but switches to insert mode first
# RIGHT-Arrow
Normal: if cursor at last character of line, goes to insert mode and then right
# Ctrl-R
Visual: Opens search and replace prompt applicable to the highlighted text
Insert: Runs the program from the terminal (only works for Python, C and java)
# Alt-left/right
Insert|Visual: moves the cursor 6 lines up/down.
# Alt-up/down
Insert|Visual: moves the editor screen up/down.


# _AUTOCOMPLETE: tab_
Insert: if after 1 or more character (no spaces), then it will attempt to autocomplete the word or bring up a selection of words to choose to autcomplete with

# _SMART BRACES_
* Adding a (round or square) open brace will autocomple it if it does not see that it would complete a single closing brace.
* Backspacing on and open or closed brace will also remove its pair if it has one
* Highlighting text and then adding and open brace will wrap the highlighted text in the typed brace
* There is also a similar completion built for apostrophe (')

# _SPECIFIC TO C_ 
# Ctrl-/
Insert: comments current line C style with /* ... * /
# Curly brace {
Insert: completes the brace and adds indentation like mose editors would/should
# Statement autocomplete
Insert: Typing 'for', 'if', 'while' followed by 'TAB' autocompletes the statement with braces and curly braces as well as indentation and semicolon inside of the braces
# main-TAB
Insert: adds stdlib and stdio includes as well as the main function with arguments and return EXIT_SUCCESS
# ctrl-p
Insert: adds a print statement
(While highlighting text): adds a print statement where what you higlighted is being printed out.
# ctrl-d
(while higlighting text): if higlightinh 'int x', it will automatically move it to the top of the function, but keep the x where you highlighted it.

# _SPECIFIC TO PYTHON_
# main-TAB
Insert: autocompletes the main defs for python
# for-TAB
Insert: autocompletes to 'for item in N:'
# ctrl-p
Insert: adds a print statement
<While highlighting text>: adds a print statement where what you higlighted is being printed out
  
# _SPECIFIC TO NASM_
# main-TAB
Insert: autcompletes to a template that is usually used to write assembly code
