set -e

# configs
# default user dir
USER_DIR="/home/dhina17"
GRUB_THEME_DIR="${USER_DIR}/.grub/themes/dracula"
THEMES_DIR="${USER_DIR}/.themes/dracula-gtk"
WALLS_DIR="${USER_DIR}/wallpapers"
ALACRITTY_CONFIG_DIR="${USER_DIR}/.config/alacritty"

# System update
sudo pacman -Syu --noconfirm

# Install required packages
sudo pacman -S --noconfirm base-devel git zsh rsync wget \
        xorg xorg-xinit xf86-video-amdgpu mesa \
        i3-wm i3status alacritty \
        ttf-jetbrains-mono noto-fonts \
        feh network-manager-applet dmenu lxappearance flameshot \
        firefox telegram-desktop discord \
        nano micro mousepad pcmanfm \
        pulseaudio pavucontrol

# Setup i3 with xinit
sudo echo "exec i3" >> /etc/X11/xinit/xinitrc

# Setup audio driver
sudo echo "options snd_hda_intel index=1" > /etc/modprobe.d/default.conf

# Setup primary output. Needed for nm-applet tray.
xrandr --output eDP --primary

# Install yay
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si --noconfirm
cd ..
rm -rf yay-git

# Install required packages from AUR
# ly - display manager
yay -S --noconfirm ly android-studio visual-studio-code-bin

# Move all dotfiles to the user dir
rsync -av --progress --exclude=".git" --exclude="*.sh" --exclude="*.md"  ./ $USER_DIR/

# Install grub themes
git clone https://github.com/dracula/grub ${GRUB_THEME_DIR}
sudo echo GRUB_THEME="${GRUB_THEME_DIR}/dracula/theme.txt" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Install GTK themes
git clone https://github.com/dracula/gtk ${THEMES_DIR}

# Import wallpapers
git clone https://github.com/dracula/wallpaper ${WALLS_DIR}

# Import alacritty themes
ALACRITTY_THEMES_DIR="${ALACRITTY_CONFIG_DIR}/themes"
mkdir -p ${ALACRITTY_THEMES_DIR}
git clone https://github.com/alacritty/alacritty-theme ${ALACRITTY_THEMES_DIR}

# zsh
chsh -s $(which zsh)
# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Setup powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Install auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Install syntax highligting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Finalize the setup
source ~/.zshrc
