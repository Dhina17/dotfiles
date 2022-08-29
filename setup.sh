set -e

# configs
# default user dir
USER_DIR="/home/dhina17"
GRUB_THEME_DIR="${USER_DIR}/.grub/themes/dracula"
THEMES_DIR="${USER_DIR}/.themes/dracula-gtk"
WALLS_DIR="${USER_DIR}/wallpapers"

# System update
sudo pacman -Syu --noconfirm

# Install git
sudo pacman -S --nconfirm git

# Move all dotfiles to the user dir
cp -r .  $USER_DIR

# Install grub themes
git clone https://github.com/dracula/grub ${GRUB_THEME_DIR}
sudo echo GRUB_THEME="${GRUB_THEME_DIR}/dracula/theme.txt" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Install GTK themes
git clone https://github.com/dracula/gtk ${THEMES_DIR}

# Import wallpapers
git clone https://github.com/dracula/wallpaper ${WALLS_DIR}