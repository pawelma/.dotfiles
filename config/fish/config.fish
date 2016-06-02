set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '+'
set __fish_git_prompt_char_untrackedfiles '⚡'
set __fish_git_prompt_char_stashstate '•'
set __fish_git_prompt_char_upstream_ahead '→'
set __fish_git_prompt_char_upstream_behind '←'
set __fish_git_prompt_char_upstream_equal '≈'

# Initialize rvm on startup
rvm reload > /dev/null
# load rspec functions
rspec --help > /dev/null
be --help > /dev/null

# ALIASES
# urxvt ssh alias
alias ssh="env TERM=xterm ssh"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gl='rvm gemset list'

# tail aliases
alias ta='cd /var/log/cubiware & tail -f *.log' # tail all
alias tm='cd /var/log/cubiware & tail -f (ls | grep log | grep -v nginx)' # tail only middleware
alias tn='cd /var/log/cubiware & tail -f (ls | grep nginx)' # tail nginx logs
alias clear-logs='cd /var/log/cubiware & echo > (ls | grep "\.log")' # echo empty string to each log file

# folders aliases
alias att='cd /home/pawel/cubiware/testing/api_test_tool'
alias apitt='cd /home/pawel/cubiware/testing/api_test_tool'
alias admin='cd /home/pawel/cubiware/main/middleware'
alias backend='cd /home/pawel/cubiware/main/backend'
alias gateway='cd /home/pawel/cubiware/main/gateway'
alias gems='cd /home/pawel/cubiware/gems'
alias main='cd /home/pawel/cubiware/main'
alias scripts='cd /home/pawel/cubiware/scripts'
alias deploy='cd /home/pawel/cubiware/deployment'
alias testing='cd /home/pawel/cubiware/testing'
alias doc='cd /home/pawel/cubiware/documentation'

# restart aliases
alias radmin='touch /home/pawel/cubiware/main/middleware/tmp/restart.txt'
alias rbackend='touch /home/pawel/cubiware/main/backend/tmp/restart.txt'
alias rgateway='touch /home/pawel/cubiware/main/gateway/tmp/restart.txt'

# sublime config alias
alias stheme='cp /home/pawel/.config/sublime-text-2/theme_configs/Afterglow.sublime-theme /home/pawel/.config/sublime-text-2/Packages/Theme\ -\ Afterglow/Afterglow.sublime-theme'

#  box alias
# alias box='echo "XMLRPC_TRACE_XML=1 cubitv; stty echo" && ssh -c 3des -i ~/.ssh/id_rsa.new admin@192.168.215.223'
alias box='echo "XMLRPC_TRACE_XML=1 QBNoRedir=1 cubitv ;  echo -n V > /dev/watchdog ; stty echo" & ssh -c 3des -i ~/.ssh/id_rsa.new admin@192.168.214.230'

# rvm aliases
alias rvmc='rvm current'
alias rvm1='rvm use ruby-1.9.3-p545@mw2'
alias rvm2='rvm use 2.1.5@mw2'
alias rvm23='rvm use 2.3.0@mw2'
alias rv1='echo ruby-1.9.3-p545@mw2 > .ruby-version'
alias rv2='echo ruby-2.1.5@mw2 > .ruby-version'

# add gopath
set -x GOPATH $HOME/goapps

# add linuxbrew to PATH
set -x PATH $HOME/github/linuxbrew/bin $PATH
set -x MANPATH $HOME/github/linuxbrew/share/man $MANPATH
set -x INFOPATH $HOME/github/linuxbrew/share/info $INFOPATH

# add completion to pssh command
make_completion pssh ssh
