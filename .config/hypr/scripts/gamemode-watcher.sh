#!/usr/bin/env sh

FLAG="$HOME/.cache/hypr_gamemode_active"

while true; do
    animations=$(hyprctl getoption animations:enabled | grep '^int:' | awk '{print $2}')
    power_profile=$(powerprofilesctl get)

    if [ "$animations" = "1" ] || [ "$power_profile" != "power-saver" ]; then
        if [ -f "$FLAG" ]; then
            # Restore animations & gaps
            hyprctl --batch "\
                keyword animations:enabled 1;\
                keyword general:gaps_in 5;\
                keyword general:gaps_out 6;\
                keyword general:border_size 1;\
                keyword decoration:rounding 18"
            rm -f "$FLAG"
            echo "Restored animations and removed gamemode flag."
        fi
    fi

    sleep 0.5
done
