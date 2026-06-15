# 🤖 Automachikku (オートマチック)

> **English** | [Tiếng Việt](README_vi.md)

Automated shell scripts designed to quickly set up, update, and install essential software on Debian/Ubuntu-based and Fedora-based systems.

---

## ✨ Features

- **🛡️ Root Guardrail:** Ensures both scripts are executed with root/sudo privileges to perform installations.
- **💻 OS Verification:** Automatically checks `/etc/os-release` (`ID` and `ID_LIKE`) to restrict execution to compatible distributions, preventing accidental run on unsupported OS architectures.
- **🔄 System Update & Upgrade:** Automates package system updates (`apt` or `dnf`).
- **📦 Essential Tools:** Installs a standard set of utilities (`curl`, `git`, build tools, `htop`, zip extraction tools, and `vlc`).
- **🧩 Flatpak & Flathub:** Configures Flatpak and registers the Flathub repository.
- **🌐 Google Chrome:** Installs the official Google Chrome web browser (via `.deb` on Debian/Ubuntu, and via `.rpm` on Fedora).
- **💬 Discord:** Installs Discord (via `.deb` on Debian/Ubuntu, and via Flatpak on Fedora).
- **📝 VS Code:** Registers the official Microsoft signing key/repository and installs Visual Studio Code.
- **⚡ All-in-One Auto Setup:** Runs all installation steps sequentially with a single action.

---

## 🖥️ Getting Started

### Installation & Execution

Clone the repository:

```bash
git clone https://github.com/justlimorina/automachikku.git
cd automachikku
```

Run the script matching your operating system:

#### For Debian, Ubuntu, and their derivatives:

```bash
sudo ./debian.sh
```

#### For Fedora and its derivatives:

```bash
sudo ./fedora.sh
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Scripting | Bash (Bourne Again Shell) |
| OS Bases | Debian, Ubuntu, Fedora and their derivatives |
| Package Managers | APT (Advanced Package Tool), DNF (Dandified YUM), Flatpak |

---

## 📂 Project Structure

```
automachikku/
├── LICENSE        # MIT License
├── README.md      # English documentation (This file)
├── README_vi.md   # Vietnamese documentation
├── debian.sh      # Automated installation script for Debian/Ubuntu
└── fedora.sh      # Automated installation script for Fedora
```

---

## ⚖️ License

Released under the **MIT License**.  
See [LICENSE](LICENSE) for the full text.
