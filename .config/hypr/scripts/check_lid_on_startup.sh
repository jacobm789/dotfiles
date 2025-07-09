#!/bin/bash

# Check if the lid is currently closed
if grep -q closed /proc/acpi/button/lid/*/state; then
    hyprctl keyword monitor "eDP-1, disable"
fi
