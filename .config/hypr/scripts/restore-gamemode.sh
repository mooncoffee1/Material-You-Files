#!/usr/bin/env sh

FLAG="$HOME/.cache/hypr_gamemode_active"

if [ -f "$FLAG" ]; then
    # Re-apply gaming mode settings
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
fi
