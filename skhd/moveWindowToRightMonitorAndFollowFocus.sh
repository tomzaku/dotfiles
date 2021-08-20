#!/bin/dash
xx=$(yabai -m query --windows --window)
# get id
curWindowId="$(echo $xx | sed -E 's/.*"id":"?([^,"]*)"?.*/\1/')"


$(yabai -m window --display next || yabai -m window --display first)
$(yabai -m window --focus "$curWindowId")
