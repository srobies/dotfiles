#!/bin/bash

kanshi &
# wlr-randr --output DP-1 --mode 2560x1440@164.834Hz --pos 0,0 &
# wlr-randr --output HDMI-A-1 --mode 2560x1440@74.995Hz --pos 2561,0 &
swaybg -i ~/Pictures/wallpapers/souredapple.png &
easyeffects --gapplication-service &
nextcloud &
setwallpaper Pictures/wallpapers/souredapple.png &
otd-daemon &
flameshot &
mako &
swayidle -w timeout 300 'wlopm --off "*"' timeout 600 'systemctl suspend' resume 'wlopm --on "*"' &
/usr/lib/pam_kwallet_init &
