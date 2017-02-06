#!/bin/bash

git submodule update
git submodule init

wget -N https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage -O gnomeshell-extension-manage
wget -N https://atom.io/download/deb -O atom.deb
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt-get update
sudo apt-get -y install build-essential cmake curl fish git python-dev python-pip

sudo pip install pip --upgrade
sudo pip install conan autopep8 jedi

sudo dpkg -i atom.deb

sudo apt-get install libappindicator1 libindicator7 libpango1.0-0 libpangox-1.0-0
sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo Flat-Plat/install.sh
sudo rm -rf '/usr/share/icons/Flat Remix'
sudo cp -r 'Flat-Remix/Flat Remix' /usr/share/icons

./gnomeshell-extension-manage --install --extension-id 307

oh-my-fish/bin/install --offline -y
