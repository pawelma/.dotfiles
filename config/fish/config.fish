# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
# colors
set -g _material_base  263238
set -g _material_select 546E7A
set -g _material_comment 607D8B
set -g _material_red   FF5555
set -g _material_teal  80CBC4
set -g _material_green 50FA7B

set -g magenta (set_color magenta)
set -g red (set_color red)
set -g cyan (set_color cyan)
set -g white (set_color white)
set -g black (set_color black)
set -g blue (set_color blue)
set -g normal (set_color normal)
set -g yellow (set_color yellow)
set -g green (set_color green)
set -g gray (set_color -o black)
set -g material_base (set_color $_material_base)
set -g material_select (set_color $_material_select)
set -g material_comment (set_color $_material_comment)
set -g material_red (set_color $_material_red)
set -g material_teal (set_color $_material_teal)
set -g material_green (set_color $_material_green)


set -g bg_magenta (set_color -b magenta)
set -g bg_red (set_color -b red)
set -g bg_cyan (set_color -b cyan)
set -g bg_white (set_color -b white)
set -g bg_black (set_color -b black)
set -g bg_blue (set_color -b blue)
set -g bg_normal (set_color -b normal)
set -g bg_yellow (set_color -b yellow)
set -g bg_green (set_color -b green)
set -g bg_material_red (set_color -b $_material_red)
set -g bg_material_teal (set_color -b $_material_teal)
set -g bg_material_green (set_color -b $_material_green)

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

# ALIASES
# URxvt ssh alias
alias ssh="env TERM=xterm ssh"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gl='rvm gemset list'

# gem 'm' alias (set TEST ENV by default)
alias t="env RAILS_ENV=test env RACK_ENV=test m"

# add gopath
#set -x GOPATH $HOME/goapps

# add linuxbrew to PATH
#set -x PATH $HOME/github/linuxbrew/bin $PATH
#set -x MANPATH $HOME/github/linuxbrew/share/man $MANPATH
#set -x INFOPATH $HOME/github/linuxbrew/share/info $INFOPATH
#set -x JAVA_HOME /usr/lib/jvm/java-7-oracle

# add completion to pssh command
#make_completion pssh ssh
if test -f /home/pawel/.autojump/share/autojump/autojump.fish; . /home/pawel/.autojump/share/autojump/autojump.fish; end

# Load conf.d configurations
#source $HOME/.config/fish/conf.d/*.fish
for custom_conf in $HOME/.config/fish/conf.d/*.fish
  source $custom_conf
end

