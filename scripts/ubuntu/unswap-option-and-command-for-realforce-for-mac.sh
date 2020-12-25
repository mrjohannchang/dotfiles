#!/usr/bin/env bash

username=$(echo "${BASH_SOURCE[0]}" | sed 's%^/home/\([^/]\+\)/.*%\1%g')
xenv="env DISPLAY=:0 XAUTHORITY=/run/user/$(id -u $username)/gdm/Xauthority"

$xenv xinput -list | grep -F REALFORCE | while read -r line; do
  keyboard_id=$(echo $line | sed 's/.*id=\([0-9]\+\).*/\1/g')
  $xenv setxkbmap -device ${keyboard_id} -option  # clear existing settings
done
