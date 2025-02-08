#!/bin/sh

GAME_PATH="/base_files"
GAME_PORT=${IW4X_NET_PORT:-28960}

# Make sure game files are mounted
if [[ ! -d $GAME_PATH ]]; then
    echo "No game files detected, please mount a game folder to $GAME_PATH"
    exit 1
fi

# Needed to find DLLs
export WINEPATH="$GAME_PATH"
export BASE_INSTALL="$GAME_PATH"
export IW4x_INSTALL="/iw4x"

# Start server with forwarded arguments
wine iw4x.exe -dedicated -stdout \
    +set net_port "$GAME_PORT" \
    +set fs_game "" \
    +set sv_lanonly "0" \
    +exec "server.cfg" \
    +set logfile "1" \
    +set party_enable "0" \
    "$@" \
    +map_rotate
