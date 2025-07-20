#!/bin/bash

FLAG="$HOME/.cache/caffeinated_active"

if [ -f "$FLAG" ]; then
    echo '{"text": "󰅶", "class": "caffeinated"}'
else
    echo ''
fi
