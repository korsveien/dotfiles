setxkbmap -layout us -variant altgr-intl
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# Set typematic delay to 200ms and rate to 30Hz
xset r rate 200 30


# systray applets
sudo nm-applet &>/dev/null &
sudo cbatticon -u 20 -i standard -c "poweroff" -l 15 -r 3 &

while true
do
    DATE=$(date +"%H:%M")
    xsetroot -name "$DATE"
    sleep 1m
done &

redshift -l 59.84:10.74 &

xrandr --output eDP1 --output DP1 --auto --left-of eDP1

# start dwm
exec dwm
