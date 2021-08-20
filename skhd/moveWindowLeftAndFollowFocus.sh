#!/bin/dash
# curWindowId="$(jq -re ".id" <<<$(yabai -m query --windows --window))"
xx=$(yabai -m query --windows --window)
# get id
curWindowId="$(echo $xx | sed -E 's/.*"id":"?([^,"]*)"?.*/\1/')"

focusWindow() {
    $(yabai -m window --focus $1) # $1 is the first argument passed in (window id).
}

$(yabai -m window --space prev)

focusWindow "$curWindowId"
