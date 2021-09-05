#!/bin/bash
# Do all setup necessary for a new system

#install necessary programs
sudo pacman -S --noconfirm --needed \
    alacritty \
    clang \
    dunst \
    emacs \
    firefox \
    fzf \
    git \
    libnotify \
    lightdm \
    lightdm-gtk-greeter \
    noto-fonts-emoji \
    openssh \
    playerctl \
    pulseaudio \
    pulseaudio-alsa \
    python-pip \
    python3 \
    qtile \
    rclone \
    ripgrep \
    rofi \
    sudo \
    thunderbird \
    ttf-fantasque-sans-mono \
    vifm \
    wget \
    xdg-user-dirs \
    xorg-server \
    xorg-xinput \
    xorg-xrandr \

sudo systemctl enable lightdm
sudo systemctl enable NetworkManager

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
if [[ ! -f $vimPlug ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Install paru
cd $reposFolder
if !(pacman -Q paru); then
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
fi

# AUR applications
# paru --needed --noconfirm discord_arch_electron spotify zoom

# Check which dotfiles are needed
if [[ $HOSTNAME == ARCH ]]; then
    machine=_desktop
else
    machine=_laptop
fi

cd $HOME
ln -sf $HOME/repos/dotfiles/.gitconfig .gitconfig

# Symlink .config folders/files
cd $HOME/repos/dotfiles
configFiles=(.bash_profile .bashrc .tmux.conf)
configFolders=(nvim alacritty qtile rclone dunst rofi vifm)

# Doom emacs files
if [[ ! -e $HOME/.doom.d ]]; then # Check if doom emacs is installed
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
fi
ln -sT $HOME/repos/dotfiles/.doom.d $HOME/.doom.d

# Cp these files. Don't work well with symlinks
for i in ${configFiles[@]}; do
    if [[ ! -e $HOME/$i ]]; then
        cp $i $HOME
    fi
done

repoConfigFolder=$HOME/repos/dotfiles/.config
homeConfigFolder=$HOME/.config

for i in ${configFolders[@]}; do
    if [[ $i == nvim ]]; then
        mkdir -p $HOME/.config/$i
        ln -sT $repoConfigFolder/$i/init.vim $homeConfigFolder/$i/init.vim
        ln -sT $repoConfigFolder/$i/coc-settings.json $homeConfigFolder/$i/coc-settings.json
    elif [[ $i == alacritty ]]; then
        mkdir -p $HOME/.config/$i
        ln -sT $repoConfigFolder/$i/alacritty$machine.yml $homeConfigFolder/$i/alacritty.yml
    elif [[ $i == qtile ]]; then
        mkdir -p $HOME/.config/$i
        ln -sT $repoConfigFolder/$i/config$machine.py $homeConfigFolder/$i/config.py
    else
        ln -sT $repoConfigFolder/$i $homeConfigFolder/$i
    fi
done
