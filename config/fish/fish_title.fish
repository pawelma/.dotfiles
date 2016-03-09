function terminal_name
  cat .terminal-name
end

function fish_title
  if test -f .terminal-name
    echo (terminal_name)
  else
    echo "fish"
  end
end
