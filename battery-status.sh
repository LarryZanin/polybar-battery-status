#!/bin/sh

# Paths to power files
    PATH_AC="/sys/class/power_supply/AC"
    PATH_BATTERY="/sys/class/power_supply/BAT0"
    PATH_BATTERY_LOG="/tmp/battery-check.log"

# Original values

    ac=0
    battery_level=0
    battery_max=0
    type="none"

# Function to check if the device is a laptop or desktop

    if [ -d "$PATH_BATTERY" ]; then
        if [ -f "$PATH_BATTERY/energy_now" ] && [ -f "$PATH_BATTERY/energy_full" ]; then
            type="energy"
            echo "Laptop detected with 'energy' files." > "$PATH_BATTERY_LOG"
        elif [ -f "$PATH_BATTERY/charge_now" ] && [ -f "$PATH_BATTERY/charge_full" ]; then
            type="charge"
#echo "$type"
            echo "Laptop detected with 'charge' files." > "$PATH_BATTERY_LOG"
        else
            type="error"
            echo "Battery directory exists, but required files are missing."
        fi
    else
        echo "No battery directory found. Likely a desktop." > "$PATH_BATTERY_LOG"
    fi

# Display function

    ac=$(cat "$PATH_AC/online")
    battery_level=$(cat "$PATH_BATTERY/"$type"_now")
    battery_max=$(cat "$PATH_BATTERY/"$type"_full")

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if [ "$ac" -eq 1 ]; then

        if [ "$battery_percent" -gt 97 ]; then
            echo "%{F#00ff00}"
	else

	    if [ "$battery_percent" -gt 89 ]; then
                icon="%{F#33ff00}󱐋󰂂"
            elif [ "$battery_percent" -gt 79 ]; then
                icon="%{F#66ff00}󱐋󰂁"
            elif [ "$battery_percent" -gt 69 ]; then
                icon="%{F#99ff00}󱐋󰂀"
            elif [ "$battery_percent" -gt 59 ]; then
                icon="%{F#ccff00}󱐋󰁿"
            elif [ "$battery_percent" -gt 49 ]; then
                icon="%{F#ffff00}󱐋󰁾"
            elif [ "$battery_percent" -gt 39 ]; then
                icon="%{F#ffcc00}󱐋󰁽"
            elif [ "$battery_percent" -gt 29 ]; then
                icon="%{F#ff9900}󱐋󰁼"
            elif [ "$battery_percent" -gt 19 ]; then
                icon="%{F#ff6600}󱐋󰁻"
            elif [ "$battery_percent" -gt 9 ]; then
                icon="%{F#ff3300}󱐋󰁺"
            else
                icon="%{F#ff0000}󱐋󰂎"
            fi
            echo "$icon $battery_percent%"
	fi
    else
        if [ "$battery_percent" -gt 89 ]; then
            icon="%{F#33ff00}󰂂"
        elif [ "$battery_percent" -gt 79 ]; then
            icon="%{F#66ff00}󰂁"
        elif [ "$battery_percent" -gt 69 ]; then
            icon="%{F#99ff00}󰂀"
        elif [ "$battery_percent" -gt 59 ]; then
            icon="%{F#ccff00}󰁿"
        elif [ "$battery_percent" -gt 49 ]; then
            icon="%{F#ffff00}󰁾"
        elif [ "$battery_percent" -gt 39 ]; then
            icon="%{F#ffcc00}󰁽"
        elif [ "$battery_percent" -gt 29 ]; then
            icon="%{F#ff9900}󰁼"
        elif [ "$battery_percent" -gt 19 ]; then
            icon="%{F#ff6600}󰁻"
        elif [ "$battery_percent" -gt 9 ]; then
            icon="%{F#ff3300}󰁺"
        else
            icon="%{F#ff0000} 󰂎"
        fi

        echo "$icon $battery_percent%"
    fi
