#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root permissions"
  exit 1
fi

# Check OS compatibility (Debian/Ubuntu and derivatives)
if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "Error: /etc/os-release not found. Cannot verify OS compatibility."
    exit 1
fi

is_compatible=false

# Check ID
if [[ "$ID" = "debian" || "$ID" = "ubuntu" ]]; then
    is_compatible=true
fi

# Check ID_LIKE if ID is not directly matched
if [ "$is_compatible" = false ] && [ -n "$ID_LIKE" ]; then
    for like in $ID_LIKE; do
        if [[ "$like" = "debian" || "$like" = "ubuntu" ]]; then
            is_compatible=true
            break
        fi
    done
fi

if [ "$is_compatible" = false ]; then
    echo "Error: This script is only compatible with Debian, Ubuntu, or their derivatives."
    echo "Detected ID: $ID, ID_LIKE: $ID_LIKE"
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
    wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install /tmp/google-chrome-stable_current_amd64.deb -y
    rm /tmp/google-chrome-stable_current_amd64.deb
    echo "Installed Google Chrome successfully"
}

install_discord(){
    echo "Installing Discord..."
    apt install wget -y
    wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    apt install /tmp/discord.deb -y
    rm /tmp/discord.deb
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
        echo "Automachikku (オートマチック) Installation Tools"
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
        
        read -p "Please enter your choices (e.g. 2 4 5, or 7 for ALL): " choices

        # Normalize spaces and commas
        choices=$(echo "$choices" | tr ',' ' ' | tr -s ' ')

        if [ -z "$choices" ]; then
            continue
        fi

        for choice in $choices; do
            case $choice in
                1) update_system ;;
                2) install_essentials ;;
                3) install_flatpak ;;
                4) install_google_chrome ;;
                5) install_discord ;;
                6) install_vscode ;;
                7) install_all; break ;;
                0) echo "Exited."; exit 0 ;;
                *) echo "Invalid choice: $choice, skipping." ;;
            esac
        done
    done
}

show_menu