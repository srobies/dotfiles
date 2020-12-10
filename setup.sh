#!/bin/bash
# Do all setup necessary for a new system
dotfiles="/$HOME/repos/dotfiles"

#install necessary programs
sudo pacman -S --noconfirm --needed \
    alacritty \
    clang \
    dunst \
    emacs \
    firefox \
    fzf \
    git \
    i3-wm \
    i3lock \
    lightdm \
    lightdm-gtk-greeter \
    pulseaudio \
    pulseaudio-alsa \
    python-pip \
    python3 \
    ripgrep \
    rofi \
    ttf-fantasque-sans-mono \
    vifm \
    rclone \
    xorg-server \
    xorg-xrandr \
    xdg-user-dirs \
    wget

xdg-user-dirs-update # Create user directories

mkdir -p $HOME/repos;
cd ~/repos

reposFolder="$HOME/repos"
# Build neovim
neovimRepo="https://github.com/neovim/neovim.git"
sudo pacman -S --noconfirm --needed base-devel cmake unzip ninja tree-sitter
cd $reposFolder
if !(nvim -v >/dev/null); then # Check if neovim installed
    git clone "$neovimRepo"
    cd neovim
    make
    make install
fi
sudo pacman -S --noconfirm --needed npm nodejs
# Install vim-plug
vimPlug=~/.local/share/nvim/site/autoload/plug.vim
if [[ ! -f "$vimPlug" ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   cp -r $HOME/repos/dotfiles/.config/nvim $/.config/
fi

# Install paru
cd $reposFolder
if !(pacman -Q paru); then
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm -
fi

# AUR applications
paru --needed --noconfirm discord_arch_electron
paru --needed --noconfirm spotify
paru --needed --noconfirm polybar
paru --needed --noconfirm zoom

# Copy .config folders/files
cd $HOME/repos/dotfiles
configFiles=(.bash_profile .bashrc .doom.d .tmux.conf .gitconfig .git .ssh)
configFolders=(.config/alacritty .config/i3 .config/polybar .config/rofi .config/vifm)

for i in ${configFiles[@]}; do
    echo "$i"
    if [[ ! -e $HOME/$i ]]; then
        cp -r $i $HOME
    fi
done

for i in ${configFolders[@]}; do
    if [[ ! -d $HOME/$i ]]; then
        cp -r $i $HOME/.config
    fi
done
