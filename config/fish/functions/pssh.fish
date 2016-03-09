function pssh
  # set ssh production terminal colors
  printf '\x1b]10;%s\a\x1b]11;%s\a' Azure DarkSlateGray
  ssh ARGV
  # return to normal terminal colors
  printf '\x1b]10;%s\a\x1b]11;%s\a' "#DEDEDE" "#1c1b1a"
end
