function left
  ruby -e 'require "time"; s=(Time.parse(ARGV[0]) - Time.now);puts "#{(s/3600).to_i}:#{(s/60%60).to_i.to_s.rjust(2,"0")}"' (since | awk '{print $3}')
end
