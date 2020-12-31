#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" = /home/* ]]; then
  username=$(echo "${BASH_SOURCE[0]}" | sed 's%^/home/\([^/]\+\)/.*%\1%g')
else
  username=${USER}
fi
xenv="env DISPLAY=:0 XAUTHORITY=/run/user/$(id -u $username)/gdm/Xauthority"

$xenv setxkbmap -option  # clear existing settings
$xenv setxkbmap -option ctrl:swapcaps
