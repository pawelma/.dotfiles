function br
  bundle exec rspec $argv
end

function r
  rspec $argv
end

function dbr
  bundle exec ruby -d -S rspec $argv
end
