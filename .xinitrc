#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

mpv ~/Documents/startup_sound.opus &
setxkbmap lv &
#xmodmap ~/.config/Xmodmap/Xmodmap
#setxkbmap -option grp:lctrl_lwin_toggle -option shift:both_capslock -option caps:ctrl_modifie & # It doesn't work when

xrandr --setprovideroutputsource modsetting NVIDIA-0 &
xrandr --auto &

~/.fehbg &
picom &
dwmblocks &

exec dwm
