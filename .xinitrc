setxkbmap -layout us -variant altgr-intl
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap


# Set typematic delay to 200ms and rate to 30Hz
xset r rate 200 30

xrandr --output DP2 --auto --left-of eDP1

~/.config/dwm/bar.sh &

feh --bg-scale "${XDG_DATA_HOME}/wallpapers/arch.png"
redshift -l 59.84:10.74 &

# start dwm
exec dwm
