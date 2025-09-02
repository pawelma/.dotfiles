function dber --description 'bundle exec rspec'
  git apply .before_tests.patch 2> /dev/null
  if test -e bin/rspec
    rdbg -O -c -- bin/rspec $argv
  else 
    rdbg -O -c -- bundle exec rspec $argv
  end
  # git apply -R .before_tests.patch 2> /dev/null
end
