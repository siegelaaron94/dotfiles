#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    apt-get update
    apt-get install build-essential cmake curl fish git python-dev python-pip

    chsh -s /usr/bin/fish

    echo "Downloading atom..."
    wget https://atom.io/download/deb -O atom.deb
    echo "Installing atom..."
    dpkg -i atom.deb
    rm atom.deb

    #https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage
    #http://bernaerts.dyndns.org/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script
else
    output=$(fish -c 'omf --version')
    if [ "$?" -ne 0 ]; then
        echo "Installing oh-my-fish..."
        output=$(`curl -L http://get.oh-my.fish | fish`)
    else
        echo "Updating oh-my-fish..."
        output=$(fish -c 'omf update')
    fi

    packages=$(fish -c 'omf list')
    if ! [[ $packages =~  robbyrussell ]]; then
        echo "Installing robbyrussell theme..."
        fish -c 'omf install robbyrussell'
    fi
fi
