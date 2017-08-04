#!/usr/bin/bash
pushd `dirname $0` > /dev/null
dotfile_path=`pwd -P`
popd > /dev/null

sudo pacman -S --needed gnome atom blender clang clang-tools-extra cloc cmake cups fish gdb gimp git gnome-tweak-tool hplip meld networkmanager ninja nodejs npm ntfs-3g openssh python2-pip python-pip tmux unrar valgrind wireless_tools wpa_supplicant yaourt base-devel 


yaourt -S --needed google-chrome chrome-gnome-shell-git flatplat-theme-git paper-icon-theme-git nerd-fonts-complete  


rm  -f ~/.vimrc
ln -sf $dotfile_path/vimrc ~/.vimrc 

rm -f ~/.vim
ln -sf $dotfile_path/vim  ~/.vim 

rm  -f ~/.config/fish/config.fish 
ln -sf $dotfile_path/config/fish/config.fish ~/.config/fish/config.fish

rm -f ~/Pictures/Wallpapers
ln -sf $dotfile_path/Wallpapers ~/Pictures

rm -f ~/.ycm_extra_conf.py
ln -sf $dotfile_path/ycm_extra_conf.py ~/ycm_extra_conf.py

rm -f ~/.config/omf/theme
ln -sf $dotfile_path/config/omf/theme ~/.config/omf/theme 


#error: target not found: substance-designer
#error: target not found: substance-painter
