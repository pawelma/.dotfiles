function _prompt_cmd_duration -S -d 'Show command duration'
  [ "$CMD_DURATION" -lt 10 ]; and return

  set_color $_material_comment
  set_color -b $_material_green

  if [ "$CMD_DURATION" -lt 5000 ]
    echo -n -s $_clock_glyph
    echo -ns $CMD_DURATION 'ms '
  else if [ "$CMD_DURATION" -lt 60000 ]
    echo -n -s $_clock_glyph
    math "scale=1;$CMD_DURATION/1000" | sed 's/\\.0$//'
    echo -n 's '
  else if [ "$CMD_DURATION" -lt 3600000 ]
    set_color -b $_material_red
    echo -n -s $_clock_glyph
    math "scale=1;$CMD_DURATION/60000" | sed 's/\\.0$//'
    echo -n 'm '
  else
    set_color -b $_material_red
    echo -n -s $_clock_glyph
    math "scale=2;$CMD_DURATION/3600000" | sed 's/\\.0$//'
    echo -n 'h '
  end
end

function _prompt_ruby -S -d 'Show the current ruby version and gemset'
  # set_color -b $_material_teal
  # set_color $fish_color_autosuggestion
  echo -n -s $bg_material_teal $material_select $_diamond_glyph (rvm current | cut -c 6-)
end

function fish_right_prompt
  _prompt_cmd_duration
  _prompt_ruby

  set_color normal
end
