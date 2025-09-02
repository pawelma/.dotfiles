function esp --description "compile upload and trace logs of ESP config"
  esphome compile $argv && esphome upload $argv && esphome logs $argv
end
