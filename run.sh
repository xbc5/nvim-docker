#!/bin/bash

[[ -z "$1" ]] && { echo "You must provide a working directory"; exit 1; }


proj="$(dirname `realpath $0`)"
workdir="${proj}/$1"


if ! [[ -d "$workdir" ]]; then
  # see :h stdpath() for a complete list
  for d in local config; do
    mkdir --parents "${workdir}/$d"
  done
  touch "${workdir}/${d}/init.vim"
fi


docker run \
  --rm \
  -it \
  --network host \
  --volume ${workdir}/local:/home/user/.local/share/nvim:rw \
  --volume ${workdir}/config:/home/user/.config/nvim:rw \
  xbc5/nvim-docker
