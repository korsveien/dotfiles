setxkbmap -layout us -variant altgr-intl
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# Set typematic delay to 200ms and rate to 30Hz
xset r rate 200 30

xrandr --output DP2 --auto --left-of eDP1

# systray applets
sudo nm-applet &>/dev/null &
sudo cbatticon -u 20 -i standard -c "poweroff" -l 15 -r 3 &

while true
do
    DATE=$(date +"%H:%M")
    xsetroot -name "$DATE"
    sleep 1m
done &

feh --bg-scale "${XDG_DATA_HOME}/wallpapers/arch.png"
redshift -l 59.84:10.74 &

# start dwm
exec dwm
