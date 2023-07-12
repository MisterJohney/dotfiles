#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap lv &

xrandr --setprovideroutputsource modsetting NVIDIA-0 &
xrandr --auto &

~/.fehbg &
picom &
dwmblocks &

exec dwm
