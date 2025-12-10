#!/bin/bash

kanshi &
# wlr-randr --output DP-1 --mode 2560x1440@164.834Hz --pos 0,0 &
# wlr-randr --output HDMI-A-1 --mode 2560x1440@74.995Hz --pos 2561,0 &
easyeffects --gapplication-service &
nextcloud &
setwallpaper Pictures/wallpapers/souredapple.png &
otd-daemon &
flameshot &
mako &
/usr/lib/pam_kwallet_init &
#swayidle -w timeout 300 'wlopm --off "*"' resume 'wlopm --on "*"' &
swayidle -w  timeout 300 'wlopm --off *' timeout 600 'systemctl suspend' resume 'wlopm --on "*"' before-sleep 'swaylock -i ~/Pictures/wallpapers/souredapple.png' &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=qtile
systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
systemctl --user start wireplumber
