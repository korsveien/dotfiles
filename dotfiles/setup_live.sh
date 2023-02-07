#!/bin/bash

setfont ter-124b
loadkeys<<EOF
keymaps 0-127
keycode 58 = Control
EOF
iwctl station wlan0 connect Hovleriet
