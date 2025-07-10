#!/usr/bin/env bash

SOURCE_DIR="$(pwd)/.config"
TARGET_DIR="$HOME/.config"

# Make sure source exists
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: $SOURCE_DIR does not exist."
    exit 1
fi

echo "Linking configs from $SOURCE_DIR to $TARGET_DIR"

for item in "$SOURCE_DIR"/*; do
    name="$(basename "$item")"
    target="$TARGET_DIR/$name"

    # Remove existing file/folder/symlink if it exists
    if [[ -e "$target" || -L "$target" ]]; then
        echo "Removing existing: $target"
        rm -rf "$target"
    fi

    # Create symlink
    ln -s "$item" "$target"
    echo "Linked $name → ~/.config/$name"
done

echo "✅ Done linking configs."
