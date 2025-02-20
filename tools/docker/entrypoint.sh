#!/bin/sh

GAME_PATH="/base_files"
GAME_PORT=${IW4X_NET_PORT:-28960}

ARGS=""

# Make sure game files are mounted
if [ ! -d "$GAME_PATH" ]; then
    echo "No game files detected, please mount a game folder to $GAME_PATH"
    exit 1
fi

if ! command -v wine &> /dev/null; then
    echo "Wine is not installed."
    exit 1
fi

if [ ! -f "$GAME_PATH/iw4x.exe" ]; then
    echo "iw4x.exe not found in $GAME_PATH"
    exit 1
fi

# Check if a password was provided
if [ -n "$RCON_PASSWORD" ]; then
    ARGS="$ARGS +set rcon_password $RCON_PASSWORD"
fi

# Needed to find DLLs
export WINEPATH="$GAME_PATH"
export BASE_INSTALL="$GAME_PATH"
export IW4x_INSTALL="/iw4x"

# Start server with forwarded arguments
wine iw4x.exe -dedicated -stdout \
    +set net_port "$GAME_PORT" \
    +set sv_lanonly "0" \
    +exec "server.cfg" \
    +set logfile "1" \
    +set party_enable "0" \
    $ARGS \
    "$@" \
    +map_rotate

if [ $? -ne 0 ]; then
    echo "IW4x server failed to start."
    exit 1
fi

echo "IW4x server started."
