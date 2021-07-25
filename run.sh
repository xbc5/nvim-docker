#!/bin/bash

[[ -z "$1" ]] && { echo "You must provide a working directory"; exit 1; }
[[ "$1" == "data" ]] && { echo "Not the data dir"; exit 1; }


proj="$(dirname `realpath $0`)"
workdir="${proj}/$1"


if ! [[ -d "$workdir" ]]; then
  # see :h stdpath() for a complete list
  mkdir --parents "${workdir}/local"
  mkdir --parents "${workdir}/config"

  cp "${proj}/init.vim" "${workdir}/config/"

  # cloning for every working dir is not ideal, but because docker likes
  #  to take ownership of a volume's full path (i.e. chowns root:root) then
  #  none of the parents are writable. This at least keeps the full path owned
  #  by user, and additionally iosolates packer between configurations. One drawback
  #  is that you may be running different packer versions between different configs,
  #  so be aware of that.
  start="${workdir}/local/site/pack/packer/start"
  mkdir --parents "$start"
  git clone https://github.com/wbthomason/packer.nvim "${start}/packer.nvim"
fi


docker run \
  --user user:user \
  --rm \
  -it \
  --network host \
  --volume ${workdir}/local:/home/user/.local/share/nvim:rw \
  --volume ${workdir}/config:/home/user/.config/nvim:rw \
  xbc5/nvim-docker
