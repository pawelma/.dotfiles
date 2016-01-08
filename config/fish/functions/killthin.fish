function killthin
  set pid (ps aux | grep thin | grep start | awk '{print $2}')
  echo "Killing Thin instances with PIDs: $pid"
  kill -9 $pid
end
