#!/bin/sh

xrdb -merge ~/.Xresources
xmodmap ~/.config/xmodmap/modmap.file
ck-launch-session awesome
