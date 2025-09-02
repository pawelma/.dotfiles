function ko -d 'kill all processes that are matching name'
  ps aux | rg $argv | awk '{for (i=11; i<=NF; i++) printf "%s ", $i; print ""}'
  echo '  press any key to kill'
  read -p ''
  kill -9 $(ps aux | rg $argv | awk '{print $2}')
end
