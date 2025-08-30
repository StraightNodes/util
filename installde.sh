#!/bin/bash
set -e

echo "=========================================================================="
echo " RDP Desktop Environment Installer (Made by Rose1440 for StraightNodes)"
echo "=========================================================================="
echo
echo "Choose a Desktop Environment to install:"
echo "1) XFCE4 (lightweight)"
echo "2) LXDE (very lightweight)"
echo "3) MATE (moderate)"
echo "4) KDE Plasma (heavy)"
echo "5) GNOME (heavy)"
echo
read -p "Enter your choice [1-5]: " choice

DE_NAME=""
INSTALL_CMD=""

case $choice in
    1)
        DE_NAME="XFCE4"
        INSTALL_CMD="apt install -y xfce4 xfce4-terminal dbus-x11 x11-xserver-utils"
        ;;
    2)
        DE_NAME="LXDE"
        INSTALL_CMD="apt install -y lxde-core lxterminal dbus-x11 x11-xserver-utils"
        ;;
    3)
        DE_NAME="MATE"
        INSTALL_CMD="apt install -y ubuntu-mate-core mate-desktop-environment mate-terminal dbus-x11 x11-xserver-utils"
        ;;
    4)
        DE_NAME="KDE Plasma"
        INSTALL_CMD="apt install -y kde-plasma-desktop dbus-x11 x11-xserver-utils"
        ;;
    5)
        DE_NAME="GNOME"
        INSTALL_CMD="apt install -y gnome-core gnome-terminal dbus-x11 x11-xserver-utils"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Installing $DE_NAME..."
DEBIAN_FRONTEND=noninteractive apt update
$INSTALL_CMD

DEBIAN_FRONTEND=noninteractive apt install -y xrdp

if [ ! -f /usr/bin/systemctl ]; then
    bash <(curl -fsSL https://raw.githubusercontent.com/StraightNodes/util/refs/heads/main/systemctl.sh)
fi

systemctl enable xrdp
systemctl start xrdp

read -p "Enter username for RDP login (leave empty to skip creating a new user): " username

if [ -n "$username" ]; then
    read -s -p "Enter password for user $username: " password
    echo
    read -s -p "Confirm password: " password2
    echo

    if [ "$password" != "$password2" ]; then
        echo "Passwords do not match. Exiting."
        exit 1
    fi

    useradd -m -s /bin/bash "$username" || echo "User $username already exists."
    echo "$username:$password" | chpasswd

    echo "User $username created for RDP access."
else
    echo "No new user created. You can RDP using existing users (e.g., root)."
fi

clear
echo "======================================="
echo "Setup complete!"
echo "Desktop Environment: $DE_NAME"
echo "RDP port: 3389"
if [ -n "$username" ]; then
    echo "Use username: $username"
fi
echo "======================================="
