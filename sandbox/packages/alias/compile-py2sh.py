# use this to compile a package in this directory to an sh usable package

import glob
import os
import pathlib
import sys


sh_template = '''\
#!/bin/bash

command=$(
python3 -c """
{contents}
""")


echo $command
$command
'''


def main(argv):
    # check for argument
    if len(sys.argv) < 2:
        return f'Usage: python3 {__file__} <package-directory>'
    folderpath = sys.argv[1]
    # check if package exists
    if not os.path.isdir(folderpath):
        return f'No such directory "{folderpath}".'
    # assert one .py file
    files = list(glob.glob(f'{folderpath}/*.py'))
    ln = len(files)
    if ln != 1:
        return f'Expected exactly 1 .py file in {folderpath}, but found {ln}.'
    # compile to sh file
    py_filepath = files[0]
    sh_filepath = py_filepath.removesuffix('.py') + '.sh'
    # get contents
    with open(py_filepath, 'r') as py_file:
        py_contents = py_file.read()
    # write to sh file
    with open(sh_filepath, 'w') as sh_file:
        sh_contents = sh_template.format(contents=py_contents)
        sh_file.write(sh_contents)
    # return the alias
    filepath = pathlib.Path(sh_filepath)
    filepath = str(filepath.absolute()).removeprefix(str(filepath.home()))
    
    return f"alias cmd='. ~{filepath}'"


if __name__ == '__main__':
    print(main(sys.argv))
