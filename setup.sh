set -e

# configs
# default user dir
USER_DIR="/home/dhina17"
GRUB_THEME_DIR="${USER_DIR}/.grub/themes/dracula"
THEMES_DIR="${USER_DIR}/.themes/dracula-gtk"
WALLS_DIR="${USER_DIR}/wallpapers"

# System update
sudo pacman -Syu --noconfirm

# Install required packages
sudo pacman -S --noconfirm base-devel git zsh rsync \
        xorg xorg-xinit xf86-video-amdgpu mesa \
        i3-wm i3status \
        ttf-jetbrains-mono noto-fonts \
        feh network-manager-applet dmenu lxappearance \
        firefox telegram-desktop discord \
        nano mousepad pcmanfm 

# Setup i3 with xinit
sudo echo "exec i3" >> /etc/X11/xinit/xinitrc

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

# Install luke-st (terminal) from my fork
git clone https://github.com/Dhina17/luke-st
cd luke-st
sudo make install
cd ..
rm -rf luke-st

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
