# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gl='rvm gemset list'
# tail aliases
alias ta='cd /var/log/cubiware && ./multi-tail.sh `ls | grep log`' # tail all
alias tm='cd /var/log/cubiware && ./multi-tail.sh `ls | grep log | grep -v "nginx"`' # tail only middleware
alias tn='cd /var/log/cubiware && ./multi-tail.sh `ls | grep nginx`' # tail nginx logs
alias clear-logs='cd /var/log/cubiware && ./clear-logs.sh `ls | grep "\.log"`' # echo empty string to each log file
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
alias box='echo "XMLRPC_TRACE_XML=1 QBNoRedir=1 cubitv ;  echo -n V > /dev/watchdog ; stty echo" && ssh -c 3des -i ~/.ssh/id_rsa.new admin@192.168.215.206'

# rvm aliases
alias rvmc='rvm current'
alias rvm1='rvm use ruby-1.9.3-p545@mw2'
alias rvm2='rvm use 2.1.5@mw2'
alias rv1='echo ruby-1.9.3-p545@mw2 > .ruby-version'
alias rv2='echo ruby-2.1.5@mw2 > .ruby-version'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# support git prompt
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
export GIT_PS1_SHOWDIRTYSTATE=1

# alias for generate new configuration file for ssh aliases
alias ssh-gen-config='cat ~/.ssh/*_config > ~/.ssh/config'

# set proper terminal name if terminal-name file found
function termname() {
  if [ -f ./.terminal-name ]; then
    name=`cat .terminal-name`
    if [ ! -z "$name" ]; then
      echo -ne "\033]0;${name}\007"
    fi
  fi
}

# unset PROMPT_COMMAND
export PROMPT_COMMAND=termname
