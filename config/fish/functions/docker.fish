function d -d 'Execute command in container with custom command'
  set -l image (cat .docker-exec-name)
  if test -z "$image"
    echo 'Set image name in .docker-exec-name before running this command'
    false
  end

  set -l running_image (docker ps --format '{{.Names}}' | rg (basename (pwd))-(cat .docker-exec-name)) | head
  if test -n "$running_image"
    docker exec -it $running_image $argv
  else
    docker-compose run --rm $image $argv
  end
end

function de -d 'Execute command in container with bundle exec prepend'
  d bundle exec $argv
end

function dup -d 'Docker-compose up'
  set -l image (cat .docker-exec-name)

echo $image
  if test -z "$image"
    echo 'Set image name in .docker-exec-name before running this command'
    false
  end

  docker-compose up $image $argv
end

function dupd -d 'Docker-compose up detached'
  set -l image (cat .docker-exec-name)

  if test -z "$image"
    echo 'Set image name in .docker-exec-name before running this command'
    false
  end

  docker-compose up -d $image $argv
end

function dupa -d 'Docker compose attach'
  set -l image (cat .docker-exec-name)
  if test -z "$image"
    echo 'Set image name in .docker-exec-name before running this command'
    false
  end

  set -l running_image (docker ps --format '{{.Names}}' | rg (basename (pwd))-(cat .docker-exec-name)) | head
  if test -z "$running_image"
    dupd
  end
  set -l running_image (docker ps --format '{{.Names}}' | rg (basename (pwd))-(cat .docker-exec-name)) | head

  docker attach $running_image
end
