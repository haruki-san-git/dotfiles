#!/bin/bash

hyprpicker -r -z &
sleep 0.1
hyprshot -m region --clipboard-only --silent && notify-send "Screenshot" "Copiato negli appunti" -i camera-photo