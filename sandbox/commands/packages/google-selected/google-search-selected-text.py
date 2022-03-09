import os
query = os.popen('xsel').read()
if query.startswith('http') or query.startswith('www.'):
    link = query
else:
    link = f'google.com/search?channel=fs&client=ubuntu&q={query}'
os.system(f'firefox --new-tab "{link}"')