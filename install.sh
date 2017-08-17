#!/usr/bin/bash
pushd `dirname $0` > /dev/null
DOTFILE_PATH=`pwd -P`
popd > /dev/null

sudo pacman -S --needed autoconf automake binutils bison fakeroot file findutils flex gawk gettext grep groff gzip libtool m4 make pacman patch pkg-config sed sudo texinfo util-linux which multilib-devel wireless_tools wpa_supplicant networkmanager ntfs-3g unrar tmux yaourt clang clang-tools-extra cloc cmake fish ninja nodejs npm openssh python2-pip python-pip gdb valgrind git gnome gnome-tweak-tool cups hplip atom blender gimp meld
yaourt -S --needed google-chrome chrome-gnome-shell-git flatplat-theme-git paper-icon-theme-git nerd-fonts-complete substance-designer substance-painter

rm  -f ~/.vimrc
ln -sf $DOTFILE_PATH/vimrc ~/.vimrc 

rm -f ~/.vim
ln -sf $DOTFILE_PATH/vim  ~/.vim 

rm  -f ~/.config/fish/config.fish 
ln -sf $DOTFILE_PATH/config/fish/config.fish ~/.config/fish/config.fish

rm -f ~/Pictures/Wallpapers
ln -sf $DOTFILE_PATH/Wallpapers ~/Pictures

rm -f ~/.ycm_extra_conf.py
ln -sf $DOTFILE_PATH/ycm_extra_conf.py ~/.ycm_extra_conf.py

rm -f ~/.config/omf/theme
ln -sf $DOTFILE_PATH/config/omf/theme ~/.config/omf/theme 

dconf load / < $DOTFILE_PATH/database.dconf

GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | sed "s/'//g")
sudo cp -v --backup /usr/share{/themes/$GTK_THEME,}/gnome-shell/gnome-shell-theme.gresource
