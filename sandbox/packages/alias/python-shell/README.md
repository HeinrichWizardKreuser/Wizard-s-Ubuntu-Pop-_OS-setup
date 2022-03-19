# Python Interpreter shortcut

This script runs the ipython interpreter in the current directory.
If it determines that it has access to a file `manage.py` in the same directory, it will run the django shell instead (which also uses `ipython`)

## Terminal shortcut
Place this in your bash (sensitive to path of this folder)

```
alias shell='. ~/sandbox/packages/alias/python-shell/python-shell.sh'
```
