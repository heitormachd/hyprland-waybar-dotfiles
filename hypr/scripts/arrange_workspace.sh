#!/usr/bin/env bash

# Immediately exit if any command fails.
set -e

# Get the active workspace ID and store all window addresses in an array.
ACTIVE_WORKSPACE_ID=$(hyprctl -j activeworkspace | jq '.id')
mapfile -t WINDOWS < <(hyprctl -j clients | jq -r --argjson WSID "$ACTIVE_WORKSPACE_ID" '.[] | select(.workspace.id == $WSID) | .address')

# Exit if there are no windows to manage.
if [ ${#WINDOWS[@]} -eq 0 ]; then
    exit 0
fi

# Prepare a batch of commands to be executed all at once for maximum performance.
COMMAND_BATCH=""

# Phase 1: Build commands to make every window float.
for address in "${WINDOWS[@]}"; do
    COMMAND_BATCH+="dispatch setfloating address:$address;"
done

# Phase 2: Build commands to toggle them back to a tiled state.
for address in "${WINDOWS[@]}"; do
    COMMAND_BATCH+="dispatch togglefloating address:$address;"
done

# Execute the entire command sequence in a single, efficient batch operation.
hyprctl --batch "$COMMAND_BATCH"

