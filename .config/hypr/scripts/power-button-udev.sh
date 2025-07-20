#!/bin/bash

# Log for debugging
echo "Udev power button triggered at $(date)" >> /home/ananas/.cache/power-button-udev.log

export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
export XDG_RUNTIME_DIR=/run/user/1000
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

# Run your actual script as user ananas
sudo -u ananas /home/ananas/.config/hypr/scripts/log-screen >> /home/ananas/.cache/power-button-udev.log 2>&1
