# dotfiles

## GRUB theme
`sudo nano /etc/default/grub`

Find `#GRUB_THEME` and change to `GRUB_THEME="/home/\<name\>/.grub/themes/dracula/dracula/theme.txt" ` (Replace \<name> with user folder name)

After making changes, `ctrl + x` to save and exit

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

Reboot to see the changes.

## Credits
Themes and wallpapers from https://github.com/dracula
