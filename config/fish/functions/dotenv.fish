function dotenv --description 'Load environment variables from .env file'
  set -l envfile ".env"
  if [ (count $argv) -gt 0 ]
    set envfile $argv[1]
  end

  echo "#####################################"
  echo "Setting environment from $envfile"
  echo "#####################################"

  if test -e $envfile
    for line in (cat $envfile)
      if string match -r '^[^#]' $line > /dev/null
        echo "setting env: $line"
        set -xg (echo $line | cut -d = -f 1) (echo $line | cut -d = -f 2- | sed 's/"//g' )
      end
    end
  end

  if test "$envfile" = ".env"
    dotenv ".env.development"
    dotenv ".env.development.local"
  end
end
