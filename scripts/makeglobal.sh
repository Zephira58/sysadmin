#!/bin/bash
# makeglobal
# Usage: ./makeglobal <script_path>
# Makes a script globally executable from anywhere

set -e

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <script_path>"
    exit 1
fi

SCRIPT_PATH="$1"

# Check that file exists
if [[ ! -f "$SCRIPT_PATH" ]]; then
    echo "Error: File '$SCRIPT_PATH' not found."
    exit 1
fi

# Extract filename and remove extension
BASENAME=$(basename "$SCRIPT_PATH")
NAME="${BASENAME%.*}"

# Make the script executable
chmod +x "$SCRIPT_PATH"

# Move to /usr/local/bin
sudo mv "$SCRIPT_PATH" "/usr/local/bin/$NAME"

echo "'$NAME' is now globally accessible. You can run it from anywhere as '$NAME'."
