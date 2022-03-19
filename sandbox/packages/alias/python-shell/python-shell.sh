#!/bin/bash

command=$(
python3 -c """
import os

if os.path.exists('manage.py'):
    print('python3 manage.py shell')
else:
    print('ipython3')

""")


$command
