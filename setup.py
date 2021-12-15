#!/bin/python

import os

# TODO: Make a server category
necessary_packages = ['alacritty', 'clang', 'curl', 'firefox', 'fd', 'fzf', 'git',
        'libnotify', 'sddm', 'noto-fonts-emoji', 'neovim', 'playerctl', 'pipewire', 
        'pipewire-pulse', 'python-pip', 'qtile', 'rclone', 'ripgrep', 'base-devel', 'wget',
        'xdg-user-dirs', 'openssh', 'gnupg', 'NetworkManager', 'zathura',
        'zsh', 'zsh-completions', 'xf86-input-libinput', 'tmux', 'npm',
        'poppler', 'openssl', 'llvm', 'dbus-python', 'nvim-packer-git'
        ]
wayland_packages = ['python-pywlroots', 'wayland', 'wofi', 'grim', 'slurp', 'imv', 
        'swaybg', 'cage'
        ]
kde_packages = ['okular', 'dolphin', 'qt5ct', 'kvantum', 'spectacle']
xorg_packages = ['xorg-server', 'xorg-xinput', 'xorg-xrandr', 'rofi', 'feh']
aur_packages = ['spotify', 'dropbox', 'zoom', 'mutt-wizard', 'nerd-fonts-fantasque-sans-mono']
language_servers = ['clangd', 'pyright', 'typescript-language-server-bin', 'texlab', 'svls',
        'lua-language-server', 'bash-language-server']
laptop_packages = ['xournalpp', 'onboard', 'bluez']

# os.system('''mkdir -p /home/spencer/repos && cd /home/spencer/repos && 
#         git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si''')
packages = ' '.join(necessary_packages)
print('''
        Select laptop or desktop setup
        1. Laptop
        2. Desktop
        ''')
computer_type = input()
if('1' in computer_type):
    packages += ' ' + ' '.join(laptop_packages)

print('''
        Select needed packages. Separate your choices with commas
        1. Wayland
        2. Xorg
        3. Select KDE packages (Not the DE)
        3. AUR
        4. Language servers
        ''')
package_choice = input()

if('1' in package_choice):
    packages += ' ' + ' '.join(wayland_packages)
if('2' in package_choice):
    packages += ' ' + ' '.join(xorg_packages)
if('3' in package_choice):
    packages += ' ' + ' '.join(aur_packages)
if('4' in package_choice):
    packages += ' ' + ' '.join(language_servers)

os.system('paru -S --needed ' + packages)
os.system('sudo systemctl enable sddm')
os.system('sudo systemctl enable NetworkManager')
os.system('xdg-user-dirs-update')

# Dotfiles
config_folders = ['nvim', 'alacritty', 'qtile', 'dunst', 'tmux']
home_directory_files = ['.zshrc', '.zprofile', '.gitconfig']
for i in home_directory_files:
    os.system('ln -sf /home/spencer/repos/dotfiles/' + i + ' ' + i)

for i in config_folders:
    if(i == 'alacritty'):
        os.system('mkdir -p /home/spencer/.config/alacritty')
        if(computer_type == 1): # Laptop config
            os.system('''ln -sf /home/spencer/repos/dotfiles/alacritty/alacritty_laptop.yml 
                    /home/spencer/.config/alacritty/alacritty.yml''')
        else:
            os.system('''ln -sf /home/spencer/repos/dotfiles/alacritty/alacritty_desktop.yml 
                    /home/spencer/.config/alacritty/alacritty.yml''')
    elif(i == 'qtile'):
        os.system('mkdir -p /home/spencer/.config/qtile')
        if('1' in package_choice): # Wayland config
            os.system('''ln -sf /home/spencer/repos/dotfiles/.config/qtile/wayland_config.py
                    /home/spencer/.config/qtile/config.py''')
            os.system('''ln -sf /home/spencer/repos/dotfiles/.config/qtile/autostart_wayland_laptop.sh
                    /home/spencer/.config/qtile/autostart.sh''')
        else:
            os.system('''ln -sf /home/spencer/repos/dotfiles/.config/qtile/config.py
                    /home/spencer/.config/qtile/config.py''')
            os.system('''ln -sf /home/spencer/repos/dotfiles/.config/qtile/autostart.sh
                    /home/spencer/.config/qtile/autostart.sh''')
    else:
        os.system('ln -sf /home/spencer/repos/dotfiles/.config/' + i + ' /home/spencer/.config/' + i)
