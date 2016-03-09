function since
  cat /var/log/lock/lock.log | grep (date +"%Y-%m-%d") | awk '{print $2}' | head -n 1 | awk '{split($1, t, ":"); sum=t[1]+8; print $1"\t-\t"sum":"t[2]":"t[3]};'
end
