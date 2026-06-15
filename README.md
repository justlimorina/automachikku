# 🤖 Automachikku (オートマチック)

> **English** | [Tiếng Việt](README_vi.md)

An automated shell script designed to quickly set up, update, and install essential software on Debian, Ubuntu, and their derivatives. 

---

## ✨ Features

- **🛡️ Root Guardrail:** Ensures the script is executed with root/sudo privileges to perform installations.
- **💻 OS Verification:** Automatically checks `/etc/os-release` (`ID` and `ID_LIKE`) to restrict execution to Debian, Ubuntu, or their direct derivatives, preventing accidental run on incompatible systems.
- **🔄 System Update & Upgrade:** Automates `apt update` and `apt upgrade` to keep the system packages up to date.
- **📦 Essential Tools:** Installs a standard set of utilities (`curl`, `git`, `build-essential`, `htop`, `unzip`, `zip`, `p7zip-full`, `vlc`).
- **🧩 Flatpak & Flathub:** Configures Flatpak and integrates it with GNOME Software, adding the Flathub repository automatically.
- **🌐 Google Chrome:** Downloads the official Google Chrome `.deb` package, installs it, and cleans up the installer.
- **💬 Discord:** Downloads and installs the official Discord desktop client `.deb` package.
- **📝 VS Code:** Sets up the official Microsoft signing key and repository, and installs Visual Studio Code.
- **⚡ All-in-One Auto Setup:** Installs all components sequentially with a single action.

---

## 🖥️ Getting Started

### Prerequisites

Ensure you are running on a **Debian-based** or **Ubuntu-based** distribution.

### Installation & Execution

Clone the repository and run the script with root permissions:

```bash
git clone https://github.com/justlimorina/automachikku.git
cd automachikku
sudo ./run.sh
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Scripting | Bash (Bourne Again Shell) |
| OS Base | Debian / Ubuntu and derivatives |
| Package Managers | APT (Advanced Package Tool), Flatpak |

---

## 📂 Project Structure

```
automachikku/
├── LICENSE        # MIT License
├── README.md      # English documentation (This file)
├── README_vi.md   # Vietnamese documentation
└── run.sh         # Core automated installation script
```

---

## ⚖️ License

Released under the **MIT License**.  
See [LICENSE](LICENSE) for the full text.
