function pbe
  env RAILS_ENV=production env RAKE_ENV=production env RACK_ENV=production bundle exec $argv
end

