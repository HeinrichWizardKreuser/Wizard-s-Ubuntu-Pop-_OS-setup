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

#### Java param generation shortcut
If the text highlighted is a java function decleration, it will generate docs using the parameters:
```java
  public static String someMethod(int a, float b) {
```
If the above text is highlightedm the below text is generated
```java
  /**
   * description
   *
   * @param a the int.
   * @param b the float.
   * @return String.
   */
  public static String someMethod(int a, float b) {
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

### Swapping the top and bottom text
`ctrl+up`: move the current line / selection up one line
`ctrl+down`: move the current line / selection down one line

### Toggle / focus left side bar
`alt+\`: toggle (hide) or show (if already hidden) the left side bar
`ctrl+\`: select this file in the left side bar

### Select next/prev mention of selected text
using `ctrl+shift` and then either on of the `-` or `=` keys (to the left of backspace usually) will cycle through mentions of the selected text
(if text is selected) `ctrl+shift+-` highlight prev mention of text
(if text is selected) `ctrl+shift+=` highlight next mention of text

### Re-indent code
`f12`: reindent selected code (good for fixing bad indents without needing to do it manually)

### Join lines
In sublime-text 4 they updated the join command, but I like the old one:
`ctrl+j`: join lines

### Move to next/prev file modification
`alt+.`: select next file modication
`alt+,`: select prev file modication

### goto
This overrides the sublime "goto" command:
`ctrl+;`: shortcut for "go to anything"



## Snippets
See the `Packages/User/*.sublime-keymap` files for a variety of custom snippets. Here are a few:

### Java

#### `arraycopy`:
```java
System.arraycopy(${1:src[]}, ${2:srcPos}, ${3:dst[]}, ${4:dstPos}, ${5:len});
```

#### `PrintWriter`:
```java
PrintWriter ${1:writer} = null;
try {
    ${1} = new PrintWriter(filename);
} catch (FileNotFoundException e) {
}
for (String line : contents) {
    ${1}.println(line);
}
${1}.close();
```

There are many more, just have a look at 
`Packages/User/java-*.sublime-keymap`



### Python
#### `decorator`:
```py
def decorator(function):
    def wrapper(*args, **kwargs):
        result = function(*args, **kwargs)
        return result
    return wrapper
```

#### `"""`
```py
""" ${1:}

Args:
    param: type
        description
        example:

        {key: val}

Returns:
    description
    example:

    {key: val}
"""
```

#### `multiprocessing`
```py
import concurrent.futures
with concurrent.futures.ProcessPoolExecutor() as executor:
    process2key = {}
    for key in keys:
        process = executor.submit(func, key2args[key])
        process2key[process] = key
    for process in concurrent.futures.as_completed(process2key):
        result = process.result()
        key = process2key[process]
```