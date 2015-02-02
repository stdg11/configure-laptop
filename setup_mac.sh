#!/bin/bash

# https://sites.google.com/site/easylinuxtipsproject/ssd

cur_dir=`pwd`
home_dir=`echo $HOME`
# 
# TODO log output notify user

## Install Wireless drivers

sudo dpkg -i $cur_dir/drivers/dkms_2.2.0.3-1.1ubuntu5_all.deb
sudo dpkg -i $cur_dir/drivers/bcmwl-kernel-source_6.30.223.141+bdcom-0ubuntu2_amd64.deb

## dotfiles

# Update dependencies
sudo apt-get update

# Install programs
sudo apt-get install -y \
    python \
    git \
    emacs \
    i3 \
    i3lock \
    scrot \
    imagemagick \
    xautolock \
    zsh \
    setxkbmap \
    curl \
    libxft-dev \
    libx11-dev \
    feh \
    libxcb-randr0-dev \
    libxcb-xinerama0-dev \
    libxcb-xinerama0

# TODO drivers update + wireless connection prompt/check 

## Confirm shutdown on power button

# check symlink ~/.scripts
cp $cur_dir/dotfiles/scripts/shutdown-gui.py $home_dir/.
sudo chmod +x $home_dir/.scripts/shutdown-gui.py

sudo cp $cur_dir/etc/acpi/powerbtn.sh /etc/apci/powerbtn.sh.old
sudo cp $cur_dir/etc/acpi/powerbtn.sh /etc/acpi/powerbtn.sh
chmod +x /etc/acpi/powerbtn.sh

#look in /etc/systemd/logind.conf set handlepowerkey to ignore

# in ~/.i3/config there is a line binding the power button to ~/.scripts/shutdown-gui.py
# bindsym XF86PowerOff exec "python ~/.scripts/shutdown-gui.py"
