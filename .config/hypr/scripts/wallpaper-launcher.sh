#!/bin/bash

wall_dir="${HOME}/Pictures/aesthetic-wallpapers/landscapes"
cache_dir="${HOME}/.cache/rofi-matugen"
mkdir -p "$cache_dir"

icon_size=100
rofi_theme_override="element-icon { size: ${icon_size}px; }"

# Only list files that have matching thumbnails
selection=$(find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r file; do
    thumb="${cache_dir}/${file}"
    [ -s "$thumb" ] && echo -en "${file}\x00icon\x1f${thumb}\n"
done | rofi -dmenu -theme-str "$rofi_theme_override" -theme ~/.config/rofi/wallSelect.rasi)

[ -z "$selection" ] && exit 0

full_path="${wall_dir}/${selection}"
matugen image "$full_path"
