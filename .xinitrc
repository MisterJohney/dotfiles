#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
setxkbmap lv &

# Only for nvidia device
# xrandr --setprovideroutputsource modsetting NVIDIA-0 &
# xrandr --auto &

~/.fehbg &
picom &
dwmblocks &
wal -i ~/Downloads/wallhaven-werowr.png

exec dwm
