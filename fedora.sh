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


# Software Versions
CHROME_VERSION="150.0.7871.100"
FIREFOX_VERSION="152.0.5"
ZEN_VERSION="1.21.5b"


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
    echo "Installing Google Chrome (Target version: ${CHROME_VERSION})..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    
    if command -v rpm &> /dev/null; then
        DOWNLOADED_VERSION=$(rpm -qp --queryformat '%{VERSION}' google-chrome-stable_current_x86_64.rpm 2>/dev/null)
        if [ -n "$DOWNLOADED_VERSION" ]; then
            echo "Downloaded Google Chrome version: ${DOWNLOADED_VERSION}"
            if [ "$DOWNLOADED_VERSION" != "$CHROME_VERSION" ]; then
                echo "=================================================="
                echo "WARNING: Downloaded version ($DOWNLOADED_VERSION) differs"
                echo "         from script target version ($CHROME_VERSION)."
                echo "=================================================="
            fi
        fi
    fi

    dnf install ./google-chrome-stable_current_x86_64.rpm -y
    rm google-chrome-stable_current_x86_64.rpm
    echo "Installed Google Chrome successfully"
}

install_firefox(){
    echo "Installing Firefox (Target version: ${FIREFOX_VERSION})..."
    
    if command -v curl &> /dev/null; then
        DOWNLOADED_VERSION=$(curl -sIL "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" | grep -i "^location:" | head -n 1 | grep -oP '/releases/\K[0-9.]+(?=/linux)')
        if [ -n "$DOWNLOADED_VERSION" ]; then
            echo "Downloaded Firefox version: ${DOWNLOADED_VERSION}"
            if [ "$DOWNLOADED_VERSION" != "$FIREFOX_VERSION" ]; then
                echo "=================================================="
                echo "WARNING: Downloaded version ($DOWNLOADED_VERSION) differs"
                echo "         from script target version ($FIREFOX_VERSION)."
                echo "=================================================="
            fi
        fi
    fi

    wget -O firefox.tar.xz "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
    rm -rf /opt/firefox
    tar -xf firefox.tar.xz -C /opt/
    rm firefox.tar.xz
    
    ln -sf /opt/firefox/firefox /usr/local/bin/firefox
    
    cat <<EOF > /usr/share/applications/firefox.desktop
[Desktop Entry]
Name=Firefox
Comment=Web Browser
Exec=/opt/firefox/firefox %u
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
EOF

    echo "Installed Firefox successfully"
}

install_brave(){
    echo "Installing Brave Browser..."
    rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    echo -e "[brave-browser]\nname=Brave Browser\nbaseurl=https://brave-browser-rpm-release.s3.brave.com/x86_64/\nenabled=1\ngpgcheck=1\ngpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc" > /etc/yum.repos.d/brave-browser.repo
    dnf install brave-browser -y
    echo "Installed Brave Browser successfully"
}

install_edge(){
    echo "Installing Microsoft Edge..."
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[microsoft-edge]\nname=Microsoft Edge\nbaseurl=https://packages.microsoft.com/yumrepos/edge\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/microsoft-edge.repo
    dnf install microsoft-edge-stable -y
    echo "Installed Microsoft Edge successfully"
}

install_zen(){
    echo "Installing Zen Browser (Target version: ${ZEN_VERSION})..."
    
    if command -v curl &> /dev/null; then
        DOWNLOADED_VERSION=$(curl -s https://api.github.com/repos/zen-browser/desktop/releases/latest | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])" 2>/dev/null)
        if [ -n "$DOWNLOADED_VERSION" ]; then
            echo "Downloaded Zen Browser version: ${DOWNLOADED_VERSION}"
            if [ "$DOWNLOADED_VERSION" != "$ZEN_VERSION" ]; then
                echo "=================================================="
                echo "WARNING: Downloaded version ($DOWNLOADED_VERSION) differs"
                echo "         from script target version ($ZEN_VERSION)."
                echo "=================================================="
            fi
        fi
    fi

    wget -O zen.tar.xz "https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz"
    rm -rf /opt/zen
    tar -xf zen.tar.xz -C /opt/
    rm zen.tar.xz
    
    ln -sf /opt/zen/zen /usr/local/bin/zen
    
    cat <<EOF > /usr/share/applications/zen.desktop
[Desktop Entry]
Name=Zen Browser
Comment=Web Browser
Exec=/opt/zen/zen %u
Icon=/opt/zen/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupWMClass=zen-alpha
StartupNotify=true
EOF

    echo "Installed Zen Browser successfully"
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
    install_firefox
    install_brave
    install_edge
    install_zen
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
        echo "5) Install Firefox (Latest Stable)"
        echo "6) Install Brave Browser"
        echo "7) Install Microsoft Edge"
        echo "8) Install Zen Browser (Latest Stable)"
        echo "9) Install Discord (Flatpak)"
        echo "10) Install Visual Studio Code"
        echo "11) Install ALL (Auto)"
        echo "0) EXIT"
        echo "========================================="
        
        read -p "Please enter your choices (e.g. 2 4 6, or 11 for ALL): " choices

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
                5) install_firefox ;;
                6) install_brave ;;
                7) install_edge ;;
                8) install_zen ;;
                9) install_discord ;;
                10) install_vscode ;;
                11) install_all; break ;;
                0) echo "Exited."; exit 0 ;;
                *) echo "Invalid choice: $choice, skipping." ;;
            esac
        done
    done
}

show_menu
