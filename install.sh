#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    apt-get -y update
    apt-get -y install build-essential cmake curl fish git python-dev python-pip
    sudo pip install pip --upgrade

    pip install conan autopep8 jedi

    chsh -s /usr/bin/fish

    if ! type "atom" > /dev/null; then
        echo "Downloading atom..."
        wget https://atom.io/download/deb -O atom.deb
        echo "Installing atom..."
        dpkg -i atom.deb
        rm atom.deb
    fi

    if ! type "google-chrome" > /dev/null; then
        echo "Downloading google chrome..."
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        echo "Installing google chrome..."
        dpkg -i google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb
        apt-get -f install
    fi

    wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage
    chmod +x gnomeshell-extension-manage
    #install dash to dock
    ./gnomeshell-extension-manage --install --extension-id 307
    #rm gnomeshell-extension-manage
    #http://bernaerts.dyndns.org/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script
else
    if ! $(fish -c 'type omf' > /dev/null); then
        echo "Downloading oh-my-fish..."
        curl -L http://get.oh-my.fish > oh-my-fish-install
        echo "Installing oh-my-fish..."
        fish oh-my-fish-install --path=~/.local/share/omf --config=~/.config/omf
    else
        echo "Updating oh-my-fish..."
        output=$(fish -c 'omf update')
    fi

    packages=$(fish -c 'omf list')
    if ! [[ $packages =~  robbyrussell ]]; then
        echo "Installing robbyrussell theme..."
        fish -c 'omf install robbyrussell'
    fi

    apm install --packages-file atom-package-list.txt
    apm update
fi
