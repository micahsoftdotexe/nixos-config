#!/usr/bin/env bash

# Terminate already running waybar instances!
pkill -9 waybar
# source ~/.config/waybar/.venv/bin/activate
# pip install -r ~/.config/waybar/requirements.txt
# Launch bar
echo "---" | tee -a /tmp/waybar.log
waybar 2>&1 | tee -a /tmp/waybar.log & disown

echo "Bars launched..."