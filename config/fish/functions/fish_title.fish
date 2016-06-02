function terminal_name
  cat $argv/.terminal-name
end

function fish_title
  if test -f .terminal-name
    echo (terminal_name .)
  else if test -f ../.terminal-name
    echo (terminal_name ..)/(basename $PWD)
  else if test -f ../../.terminal-name
    echo (terminal_name ../..)/../(basename $PWD)
  else
    echo (basename $PWD)
  end
end
