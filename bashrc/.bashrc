# activate python environment in this directory or any parent directory (see TODO)
alias activate='. ~/sandbox/packages/alias/activate-recur/activate-recur.sh'

# shortcut for ipython3 or python manage.py shell if manage.py is detected
alias shell='. ~/sandbox/packages/alias//python-shell/python-shell.sh'

# django shortcuts
alias runserver='python manage.py runserver'
alias notebook='python3 manage.py shell_plus --notebook'
alias lab='python3 manage.py shell_plus --lab'

# git
alias gs='git status'
alias ga='git add'
#alias gc='git commit -m'
alias gc='python3 ~/sandbox/packages/alias/gg/gg.py'

# java (NOTE: sudo apt install skdman)
alias java15='sdk use java 15.0.0.hs-adpt'
alias java13='sdk use java 13.0.2.hs-adpt'
alias java11='sdk use java 11.0.8.hs-adpt'
alias java8='sdk use java 8.0.252-open'
