function pssh
  clear
  # set ssh production terminal colors
  printf '\x1b]10;%s\a\x1b]11;%s\a' Azure DarkSlateGray
  ssh $argv
  # return to normal terminal colors
  printf '\x1b]10;%s\a\x1b]11;%s\a' "#DEDEDE" "#1c1b1a"
end
