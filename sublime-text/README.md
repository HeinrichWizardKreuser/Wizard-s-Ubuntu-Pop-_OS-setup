# Custom Sublime Text 4 setup

Merge the `Packages` directory with in your `~/.config/sublime-text/Packages`


## Keymap scripts
See `Packages/User/ctrlp-print.py` for these commands.

### print line shortcut
`ctrl+p` generates a println statement based on the language of the file.
If text is selected, then the highlighted text will be included in the print statement.
```js
{"keys": ["ctrl+p"], "command": "ctrlp_print"},
```

### Move caret x lines up or down
`Alt+left`: moves caret x lines up
`Alt+right`: moves caret x lines down
x can be set in the keymap: (defaults to 5)
```js
{"keys": ["alt+left"], "command": "move_lines", "args": {"amount": 5 }},
{"keys": ["alt+right"], "command": "move_lines", "args": {"amount": -5 }},
```

### Scroll and move caret x lines up/down
`Alt+up`: Scrolls pane and caret x lines up
`Alt+down`: Scrolls pane and caret x lines down
x can be set in the keymap: (defaults to 5)
```js
{ "keys": ["alt+up"], "command": "scroll_lines", "args": {"amount": 5.0 } },
{ "keys": ["alt+down"], "command": "scroll_lines", "args": {"amount": -5.0 } },
```

### Smart case conversion
`ctrl+k+c`: dependent on selected text:
If text is python kwargs or dictionary, it will convert the text to the other:
```
{'a': 0, 'b': 1}   -> dict(a=0, b=1)
dict(a=0, b=1)     -> {'a': 0, 'b': 1}
**{'a': 0, 'b': 1} -> a=0, b=1
a=0, b=1           -> **{'a': 0, 'b': 1}
```
If text is a file path, it will convert it to an import statement from the `src` path:
```
my/package/path/src/packagename/subdirectory/filename.py ->
from packagename.subdirectory import filename
```
If text is CamelCase (or snake_case), it will be converted to snake_case (or CamelCase):
```
SomeVariableName   -> some_variable_name
some_variable_name -> SomeVariableName
```
It can also be used to simpy capitalize the first letter of a word:
```
text -> Text
```
Which is a useful counterpart to the already existing `ctrl+k+u` command which uppercases words:
```
text -> TEXT
```

### Multi-line comments (python only)
`ctrl+'`:
```
'''

'''
```
`ctrl+"`: (a.k.a. `ctrl+shift+'`)
```
"""

"""
```

### Insert numbers command
`Alt+0` ... `Alt+9`: generates the natural range of characters in order in all instances of cursors
If you have your caret in 5 different places (`|` represent caret)
```
arr[|]
arr[|]
arr[|]
arr[|]
arr[|]
```
You can run `Alt+0` and it will populate all five carets with 0, 1, 2, 3 and 4:
```
arr[0]
arr[1]
arr[2]
arr[3]
arr[4]
```

### Highlight next/prev word
My favorite command.
`ctrl+right`: highlight the next word
`ctrl+left`: highlight the previous word
examples (`[someword]` represents that `someword` is highlighted and `|` represents the caret)
```
int x| = someFunc(2)
```
Here the cursor is to the right of `x`, and pressing `ctrl+right` will highlight `someFunc`:
```
int x = [someFunc](2)
```
Moving it right again will highlight `2`, but you can move left as well to highlight `x` (after which you can highlight `int`)

This is very useful when say copying a paragraph of code but wanting to change a single part.

### 

## Commands
## Shortcuts
## Snippets