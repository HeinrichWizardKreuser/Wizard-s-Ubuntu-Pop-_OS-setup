import os

try:
    s = os.popen('xsel').read()

    """ s looks like
    File "/home/wizard/.../folder/file.py", line 69, in somemethod
    """
    alist = s.split()
    """ alist looks like
    'File'
    '"/home/wizard/.../folder/file.py",'
    'line'
    '69,'
    'in'
    'somemethod'
    """
    # extract file
    file = alist[1] # '"/home/wizard/.../folder/file.py",'
    file = file.split('/')[-2:] # ['folder', 'test_scrape_citations.py",']
    file = '/'.join(file) # 'tests/test_scrape_citations.py",'
    file = file[:-2] # 'tests/test_scrape_citations.py'
    # extract line num
    linenum = alist[3] # '69,'
    linenum = linenum[:-1] # '69'
    # build query
    query = f'{file}: {linenum}'

    os.system(f'echo "{query}" | xclip -selection clipboard')
except Exception as e:
    os.system(f'echo "{str(e)}" | xclip')
