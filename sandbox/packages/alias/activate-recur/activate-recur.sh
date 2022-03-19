#!/bin/bash

command=$(
python3 -c """
import os
import pathlib

# get the path until the home directory
path_to_home = str(pathlib.Path().absolute())

# gets '/home/to/this/directory'
cds = ''

index = len(path_to_home)
while index != 0:
	# sets the env folder to whatever the path is + /env
	env = f'{path_to_home[:index]}/env'
	# checks whether env exists in this directory
	isdir = os.path.isdir(env)
	# if this is indeed a directory, activate here
	if isdir:
		break
	else:
		# else it is not a directory, so we must got back
		cds += '../'
	# get the last mention of '/'
	index = path_to_home[:index].rfind('/')

# if index is 0, it didn't work
if index == 0:
	print('')
else:
	# else it did work. we can perform the cds
	# set the command
	command = 'source ' + cds + 'env/bin/activate'
	# print the command
	print(command)

""")


echo $command
$command