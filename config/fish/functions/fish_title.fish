function terminal_name
  cat .terminal-name
end

function fish_title
  if test -f .terminal-name
    if test -z "$name"
      echo (terminal_name)
    else
      echo 2
    end
  else
    echo "fish"
  end
end
