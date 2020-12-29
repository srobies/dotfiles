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
if !(pip list | rg dbus-python); then
    pip install dbus-python
fi

xdg-user-dirs-update # Create user directories

mkdir -p $HOME/repos;
cd ~/repos

reposFolder="$HOME/repos"
dotfiles="/$HOME/repos/dotfiles"
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
    makepkg -si --noconfirm
fi

# AUR applications
paru --needed --noconfirm discord_arch_electron
paru --needed --noconfirm spotify
paru --needed --noconfirm polybar
paru --needed --noconfirm zoom

# Symlink .config folders/files
cd $HOME/repos/dotfiles
configFiles=(.bash_profile .bashrc .tmux.conf .gitconfig .ssh)
configFolders=(dunst alacritty polybar rofi qtile vifm)

# Doom emacs files
mkdir -p $HOME/.doom.d
ln -sf $HOME/repos/dotfiles/.doom.d/init.el $HOME/.doom.d/init.el
ln -sf $HOME/repos/dotfiles/.doom.d/config.el $HOME/.doom.d/config.el
ln -sf $HOME/repos/dotfiles/.doom.d/packages.el $HOME/.doom.d/packages.el

# Need to fix this
# for i in ${configFiles[@]}; do
#     echo "$i"
#     if [[ ! -e $HOME/$i ]]; then
#         ln -sf $HOME/repos/dotfiles/$i $HOME/$i
#     fi
# done

# for i in ${configFolders[@]}; do
#     if [[ ! -d $HOME/.config/$i ]]; then
#         for file in $i/*; do
#             ln -sf $HOME/repos/dotfiles/.config/$i $HOME/$i/$file
#         done
#     fi
# done

cd $HOME
mkdir python_venvs
cd python_venvs
if [[ ! -d nvim ]]; then
    python -m venv nvim
    source nvim/bin/activate
    pip install pynvim
    deactivate
fi
