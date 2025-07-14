#!/usr/bin/env bash

FLAG="$HOME/.cache/hyprsunset_active"
PIDFILE="/tmp/hyprsunset.pid"

cleanup() {
    rm -f "$PIDFILE" "$FLAG"
}

# Catch termination signals and call cleanup
trap cleanup EXIT INT TERM HUP

if [ -f "$FLAG" ] && kill -0 "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    cleanup
else
    /usr/bin/hyprsunset -t 3800 -g 80 &
    echo $! > "$PIDFILE"
    touch "$FLAG"
    wait $!  # Wait for the background process; trap cleanup on exit
fi
