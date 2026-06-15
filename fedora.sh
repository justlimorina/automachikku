#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root permissions"
  exit 1
fi

# Check OS compatibility (Fedora and derivatives)
if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "Error: /etc/os-release not found. Cannot verify OS compatibility."
    exit 1
fi

is_compatible=false

# Check ID
if [[ "$ID" = "fedora" ]]; then
    is_compatible=true
fi

# Check ID_LIKE if ID is not directly matched
if [ "$is_compatible" = false ] && [ -n "$ID_LIKE" ]; then
    for like in $ID_LIKE; do
        if [[ "$like" = "fedora" ]]; then
            is_compatible=true
            break
        fi
    done
fi

if [ "$is_compatible" = false ]; then
    echo "Error: This script is only compatible with Fedora or its derivatives."
    echo "Detected ID: $ID, ID_LIKE: $ID_LIKE"
    exit 1
fi


update_system() {
    echo "Updating system..."
    dnf upgrade -y
    echo "Updated system successfully"
}

install_essentials() {
    echo "Installing Essentials..."
    dnf install -y curl git gcc gcc-c++ make htop unzip zip p7zip p7zip-plugins vlc
    echo "Installed Essentials successfully"
}

install_flatpak(){
    echo "Installing Flatpak..."
    dnf install flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "Installed Flatpak successfully"
}

install_google_chrome(){
    echo "Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    dnf install ./google-chrome-stable_current_x86_64.rpm -y
    rm google-chrome-stable_current_x86_64.rpm
    echo "Installed Google Chrome successfully"
}

install_discord(){
    echo "Installing Discord (Flatpak)..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.discordapp.Discord -y
    echo "Installed Discord successfully"
}

install_vscode(){
    echo "Installing Visual Studio Code..."
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
    dnf install code -y
    echo "Installed Visual Studio Code successfully"
}

install_all(){
    echo "=================================================="
    echo "Starting installation..."
    echo "=================================================="
    update_system
    install_essentials
    install_flatpak
    install_google_chrome
    install_discord
    install_vscode
    echo "=================================================="
    echo "Installation completed!"
    echo "=================================================="
}

show_menu() {
    while true; do
        echo ""
        echo "=================================================="
        echo "Automachikku (オートマチック) Installation Tools"
        echo "=================================================="
        echo "1) Update system (Update & Upgrade)"
        echo "2) Install Essentials"
        echo "3) Install Flatpak"
        echo "4) Install Google Chrome (RPM)"
        echo "5) Install Discord (Flatpak)"
        echo "6) Install Visual Studio Code"
        echo "7) Install ALL (Auto)"
        echo "0) EXIT"
        echo "========================================="
        
        read -p "Please enter your choice (0-7): " choice

        case $choice in
            1) update_system ;;
            2) install_essentials ;;
            3) install_flatpak ;;
            4) install_google_chrome ;;
            5) install_discord ;;
            6) install_vscode ;;
            7) install_all ;;
            0) echo "Exited."; exit 0 ;;
            *) echo "Invalid choice, please try again!" ;;
        esac
    done
}

show_menu
