#!/bin/bash

FLAG="$HOME/.cache/hypr_gamemode_active"

if [ -f "$FLAG" ]; then
    echo '{"text": "󰹂", "class": "gamemode"}'
else
    echo ''
fi
