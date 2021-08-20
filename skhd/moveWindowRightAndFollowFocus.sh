#!/bin/dash
xx=$(yabai -m query --windows --window)
# get id
curWindowId="$(echo $xx | sed -E 's/.*"id":"?([^,"]*)"?.*/\1/')"

$(yabai -m window --space next)
$(yabai -m window --focus "$curWindowId")
