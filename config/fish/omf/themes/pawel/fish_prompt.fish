# name: pawel
# A fish theme created on ocean base.


## Set this options in your config.fish (if you want to)
# set -g theme_display_user yes
# set -g default_user default_username

set _glyph_anchor " "\u2693" "
set _glyph_radioactive " "\u2622" "
set _glyph_gear " ⚙ "

set _clock_glyph " "\u25F7" "
set _diamond_glyph " "\u2666" "

function _is_in_git_directory
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _git_branch_name
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _prompt_root
    if [ (id -u $USER) -eq 0 ]
        echo -n -s $bg_yellow $black $_glyph_radioactive $normal
    end
end

function _prompt_status
    if test $CMD_STATUS -ne 0
        # error status
        echo -n -s $bg_red $material_base $_glyph_anchor  $normal
    else
        if [ $JOBS_STATUS -gt 0 ]
            # backgound jobs working
            echo -n -s $bg_yellow $material_base $_glyph_gear $normal
        else
            # correct status
            echo -n -s $bg_blue $material_base $_glyph_anchor $normal
        end
    end
end

function _prompt_user
    if [ -n "$SSH_CLIENT" ]
        echo -n -s $cyan $bg_white " " (whoami) "@" (hostname -s) " " $normal
    end
end

function _prompt_path
    echo -n -s $bg_cyan $material_base " " (prompt_pwd) " " $normal
end

function _prompt_git
    set -l git_prompt (python ~/scripts/git_status.py)
    if [ $git_prompt ]
        echo -n -s $bg_white $material_base " "$git_prompt
    end
end

function _prompt_terminate
    echo -n -s ' ' $normal
end


function fish_prompt
    set -g CMD_STATUS $status
    set -g JOBS_STATUS (jobs -l | wc -l)

    _prompt_root
    _prompt_status
    _prompt_user
    _prompt_path
    _prompt_git
    _prompt_terminate
end
