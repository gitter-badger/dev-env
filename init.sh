#!/bin/bash

fish_config=~/.config/fish/config.fish

if [ -f $fish_config ]; then
	rm $fish_config
	ln -s ./config.fish $fish_config
fi