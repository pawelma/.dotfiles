function weather
  if test ! -f /tmp/weather.cache
    curl http://wttr.in/Warsaw > /tmp/weather.cache 2> /dev/null
  end
  cat /tmp/weather.cache
end

