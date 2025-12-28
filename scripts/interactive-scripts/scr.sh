#!/usr/bin/env bash
set -e

# Folder containing your scripts (relative to where this script is)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}🔹 Executable scripts in $SCRIPT_DIR:${RESET}"

COUNT=1
for FILE in "$SCRIPT_DIR"/*; do
    if [[ -f "$FILE" && -x "$FILE" ]]; then
        echo -e "  ${GREEN}${COUNT}) $(basename "$FILE")${RESET}"
        ((COUNT++))
    fi
done

if [[ $COUNT -eq 1 ]]; then
    echo "  No executable scripts found."
fi
