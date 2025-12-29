#!/usr/bin/env bash
set -e

read -rp "Enter folder path containing .sh files: " TARGET_DIR

# Expand ~ manually
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: '$TARGET_DIR' is not a directory."
    exit 1
fi

echo
echo "Renaming .sh files in: $TARGET_DIR"
echo

shopt -s nullglob

for file in "$TARGET_DIR"/*.sh; do
    base="$(basename "$file")"
    new="${file%.sh}"

    if [[ -e "$new" ]]; then
        echo "Skipping $base → $(basename "$new") (already exists)"
        continue
    fi

    mv "$file" "$new"
    chmod +x "$new"
    echo "$base → $(basename "$new")"
done

echo
echo "Done."
