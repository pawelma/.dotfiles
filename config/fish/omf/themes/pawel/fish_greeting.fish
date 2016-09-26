function fish_greeting -d "what's up, fish?"
  set_color $meterial_green
  echo UPTIME: (uptime -p | cut -c 4-)
  set_color normal
  weather | head -7 | tail -5 &
end