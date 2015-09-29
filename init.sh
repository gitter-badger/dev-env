#!/bin/bash

function resolve_path() {
  local relative_path=$1
  echo $(dirname $relative_path)/$(basename $relative_path)
}

fish_config=~/.config/fish/config.fish

if [ -f $fish_config ]; then
	rm $fish_config
	ln -s $(pwd)/config.fish $(resolve_path $fish_config)
fi