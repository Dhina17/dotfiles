set -e

# configs
# default user dir
USER_DIR="/home/dhina17"

# Move all dotfiles to the user dir
cp -r .  $USER_DIR

# Install grub themes
sudo echo GRUB_THEME="${USER_DIR}/.grub/themes/dracula/dracula/theme.txt" >> /etc/default/grub
