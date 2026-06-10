#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root permissions"
  exit 1
fi

update_system() {
    echo "Updating system..."
    apt update && apt upgrade -y
    echo "Updated system successfully"
}

install_essentials() {
    echo "Installing Essentials..."
    apt install curl git build-essential htop unzip zip p7zip-full vlc -y
    echo "Installed Essentials successfully"
}

install_flatpak(){
    echo "Installing Flatpak..."
    apt install flatpak gnome-software gnome-software-plugin-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "Installed Flatpak successfully"
}

install_google_chrome(){
    echo "Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install ./google-chrome-stable_current_amd64.deb -y
    rm google-chrome-stable_current_amd64.deb
    echo "Installed Google Chrome successfully"
}

install_discord(){
    echo "Installing Discord..."
    apt install wget -y
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    apt install ./discord.deb -y
    rm discord.deb
    echo "Installed Discord successfully"
}

install_vscode(){
    echo "Installing Visual Studio Code..."
    apt install wget gpg apt-transport-https -y
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
    rm -f packages.microsoft.gpg
    apt update
    apt install code -y
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
        echo "   Automachikku (オートマチック) Installation Tools   "
        echo "=================================================="
        echo "1) Update system (Update & Upgrade)"
        echo "2) Install Essentials"
        echo "3) Install Flatpak"
        echo "4) Install Google Chrome"
        echo "5) Install Discord (deb)"
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