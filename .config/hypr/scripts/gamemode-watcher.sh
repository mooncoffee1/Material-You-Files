#!/usr/bin/env sh
#
#FLAG="$HOME/.cache/hypr_gamemode_active"
#
#
#while true; do
#    animations=$(hyprctl getoption animations:enabled | grep '^int:' | awk '{print $2}')
#
#    if [ "$animations" = "1" ]; then
#        if [ -f "$FLAG" ]; then
#            # Gaming mode flag still exists, but animations got turned back on — #reapply gaming mode settings
#            echo "Reapplying gaming mode settings..."
#            hyprctl --batch "\
#                keyword animations:enabled 0;\
#                keyword decoration:drop_shadow 0;\
#                keyword decoration:blur:enabled 0;\
#                keyword general:gaps_in 0;\
##                keyword general:gaps_out 0;\
#                keyword general:border_size 1;\
#                keyword decoration:rounding 0"
#            powerprofilesctl set power-saver
#        else
#            # Flag is gone — restore normal settings
##            echo "Restoring normal mode settings..."
 #           hyprctl --batch "\
  #              keyword animations:enabled 1;\
 #               keyword general:gaps_in 5;\
##                keyword general:gaps_out 6;\
#                keyword general:border_size 1;\
#                keyword decoration:rounding 18"
#            powerprofilesctl set balanced
##        fi
##    fi
#
#    sleep 0.5
#done
