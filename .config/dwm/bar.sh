#! /usr/bin/fish

function cpu
    echo " "(grep -o "^[^ ]*" /proc/loadavg)
end

function battery
    echo " "(cat /sys/class/power_supply/BAT0/capacity)"%"
end

function brightness
    echo " "(cat /sys/class/backlight/intel_backlight/brightness)
end

function mem
    echo " "(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
end

function wlan
    switch (cat /sys/class/net/wlan0/operstate 2>/dev/null)
        case up
            echo "󰤨"(nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}')"%"
        case down
            echo "󰤭 Disconnected"
        case '*'
            echo "ERROR: could not check wifi status"
    end
end

function clock
    echo (date '+%H:%M')
end

while true
    sleep 1 && xsetroot -name (echo (cpu) (brightness) (wlan) (battery) (clock))
end
