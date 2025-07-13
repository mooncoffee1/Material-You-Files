#!/usr/bin/env sh

FLAG="$HOME/.cache/caffeinated_active"
PIDFILE="/tmp/caffeinated.pid"

if [ -f "$FLAG" ]; then
    # If flag exists, kill the caffeinated process using its PID file
    if [ -f "$PIDFILE" ]; then
        kill "$(cat "$PIDFILE")" 2>/dev/null
        rm -f "$PIDFILE"
    fi
    rm -f "$FLAG"
else
    # Start caffeinated in daemon mode, let it write its own PID file
    caffeinated -d -p "$PIDFILE"
    touch "$FLAG"
fi
