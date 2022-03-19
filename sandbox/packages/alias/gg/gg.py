import os, sys

def vcmd(cmd):
    print('$', cmd)
    return cmd

def vsys(cmd):
    vcmd(cmd)
    os.system(cmd)
    return cmd

def gs():
    cmd = 'git status'
    return vsys(cmd)

def ga(*files):
    cmd = f'git add {" ".join(files)}'
    return vsys(cmd)

def gc(msg):
    newline = msg.find('\n')
    if newline != -1:
        msg = msg[:newline]
    cmd = f'git commit -m "{msg}"'
    return vsys(cmd)

def main(*argv):
    argc = len(argv)
    if argc == 0:
        return gs()
    if argc == 1:
        file = msg = argv[0]
        if isfile(file):
            return ga(file)
        return gc(msg)
    if isfile(argv[-1]):
        return ga(*argv)
    return gg(argv)

def isfile(arg):
    return os.path.exists(arg)

def find_msg_index(argv):
    for i, arg in enumerate(argv):
        if not isfile(arg):
            break
    return i

def gg(argv):
    msg_index = find_msg_index(argv)
    files, msg = argv[:msg_index], argv[msg_index:]
    msg = ' '.join(msg)
    if files:
        if msg:
            return ga(*files), gc(msg)
        return ga(*files)
    return gc(msg)

if __name__ == '__main__':
    main(*sys.argv[1:])
