function start --description 'overmind start and overmind connect combined, so that we will be attached immediatelly'
  overmind start $argv
  sleep 1
  overmind connect
end
