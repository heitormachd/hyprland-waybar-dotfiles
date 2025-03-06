#!/bin/bash

grim -g "$(slurp -w 0)" - | tee ~/Pictures/screenshots/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy
notify-send "Screenshot saved on ~/Pictures/screenshots/" "Copied to clipboard"
