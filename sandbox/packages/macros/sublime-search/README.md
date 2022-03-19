# Python Stacktrace Sublime Goto

When you run a python script and get a trace back for an error, you can highlight the line of the error and then run the macro assigned to this script.
The macro will copy the file name and the line number to the clipboard.
You can then open Sublime Text and use the "goto" command and then just paste.
Sublime will then go exactly to the file and line number of the error.
This is super useful when debuggin and acts like IntelliJ's "go to line with error"


## Installation
```
sudo apt install xsel xclip
```

## KEYBOARD SHORTCUT
```
Name: 
sublime-search

Command: 
python3 /home/wizard/sandbox/commands/packages/sublime-search/sublime-search.py

Shortcut (suggested): 
Ctrl+7
```