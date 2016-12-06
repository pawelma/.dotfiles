#!/bin/bash

if [ -f ./.rvmrc ]; then
  rvm rvmrc load > /dev/null
fi

ctags -R -f .tags --languages=ruby --exclude=.git --exclude=log --exclude=.release_cache --exclude=cache --exclude=tmp --exclude=doc .

if [ -f ./Gemfile ]; then
  ctags -R -f .gemtags --languages=ruby --exclude=.git --exclude=log $(bundle list --paths | grep $(rvm current))
fi
