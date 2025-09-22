function ber --description 'bundle exec rspec'
  git apply .before_tests.patch 2> /dev/null
  if test -e bin/rspec
    bin/rspec $argv
  else 
    bundle exec rspec $argv
  end
  # git apply -R .before_tests.patch 2> /dev/null
end
