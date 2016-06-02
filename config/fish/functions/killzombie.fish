function killzombie
  kill -9 (ps -A -ostat,ppid | awk '/[zZ]/{print $2}')
end

