#!/usr/bin/env sh

FLAG="$HOME/.cache/hypr_gamemode_active"
PIDFILE="/tmp/hypr_gamemode_watcher.pid"

echo $$ > "$PIDFILE"

while [ -f "$FLAG" ]; do
    # Check current mode settings
    animations_state=$(hyprctl getoption animations:enabled | head -n1 | awk '{print $2}')
    drop_shadow_state=$(hyprctl getoption decoration:drop_shadow | head -n1 | awk '{print $2}')

    # Gaming mode requires animations=0, blur=0, drop_shadow=0
    if [ "$animations_state" != "0" ] || [ "$blur_state" != "0" ] || [ "$drop_shadow_state" != "0" ]; then
        # Reapply gaming mode settings
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 1;\
            keyword decoration:rounding 0"
        echo "Re-applied GAMING mode settings"
    fi

    sleep 0.5
done

# When flag removed (normal mode), exit watcher
echo "Flag removed, watcher exiting."
rm -f "$PIDFILE"
