# Awesome Script 🚀💻

[![GitHub Repo stars](https://img.shields.io/github/stars/zynthera/Awesome-Script?style=social)](https://github.com/zynthera/Awesome-Script/stargazers)
[![GitHub Repo forks](https://img.shields.io/github/forks/zynthera/Awesome-Script?style=social)](https://github.com/zynthera/Awesome-Script/network/members)
[![Visitors](https://visitor-badge.laobi.icu/badge?page_id=zynthera/Awesome-Script)](https://github.com/zynthera/Awesome-Script)

Welcome to **Awesome Script**! 😎✨  
This repository houses the ultimate Hacker CLI tool with real-time notifications, command chaining, and forensic evasion. The script supports various environments including Termux. Follow the instructions below for setting up on Termux along with other Linux environments.

## Table of Contents
- [Features](#features)
- [Installation Guide](#installation-guide)
  - [Requirements](#requirements)
  - [Installation for Termux Users](#installation-for-termux-users)
  - [Installation for Unrooted Users](#installation-for-unrooted-users)
  - [Installation for Root Users](#installation-for-root-users)
- [Usage](#usage)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)
- [Contact & Support](#contact--support)

## Features 🌟
- **Real-time Notifications** 🔔  
  Immediate alerts to keep you updated on your script's events.
  
- **Forensic Evasion** 🕵️‍♂️  
  Advanced techniques to manipulate timestamps and evade detection.
  
- **Command Chaining** 🔗  
  Execute complex commands effortlessly.
  
- **Cross-Platform Support** 🌐  
  Compatible with Termux and various Linux distributions.
  
- **Secure Config Management** 🔐  
  Encrypted configuration and password protection to keep your operations safe.
  
- **Automated Backups & Cron Scheduling** ⏰  
  Keep your environment up-to-date with automated tasks.

## Installation Guide

Below you will find step-by-step instructions to install **Awesome Script** on your system.

### Requirements
Ensure you have the following dependencies installed:
- **bash** 🐚
- **gpg** 🔑
- **jq** 📦
- **whiptail** 💻
- **fzf** 🔍
- **tor** 🌀
- **nmap**, **tcpdump**, **proxychains** (and other utilities as needed)

#### For Debian/Ubuntu:
```bash
sudo apt update && sudo apt install bash gpg jq whiptail fzf tor nmap tcpdump proxychains -y
```

#### For Fedora:
```bash
sudo dnf install bash gpg jq whiptail fzf tor nmap tcpdump proxychains -y
```

#### For Arch/Manjaro:
```bash
sudo pacman -S bash gpg jq whiptail fzf tor nmap tcpdump proxychains --noconfirm
```

### Installation for Termux Users
For Termux users, follow these additional steps to install packages specific to Termux:

1. **Update Termux Packages:**
   ```bash
   pkg update && pkg upgrade
   ```

2. **Install Required Packages:**
   ```bash
   pkg install bash gpg jq whiptail fzf tor nmap tcpdump proxychains termux-api git
   ```

3. **Clone the Repository:**
   ```bash
   git clone https://github.com/zynthera/Awesome-Script.git
   cd Awesome-Script
   ```

4. **Make the Script Executable:**
   ```bash
   chmod +x official.sh
   ```

5. **Run the Script:**
   ```bash
   ./official.sh
   ```

### Installation for Unrooted Users
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/zynthera/Awesome-Script.git
   cd Awesome-Script
   ```
2. **Make the Script Executable:**
   ```bash
   chmod +x official.sh
   ```
3. **Run the Script:**
   ```bash
   ./official.sh
   ```
   *Note: Advanced features like system-wide cron jobs or systemd services may be limited in unrooted mode.*

### Installation for Root Users
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/zynthera/Awesome-Script.git
   cd Awesome-Script
   ```
2. **Make the Script Executable:**
   ```bash
   sudo chmod +x official.sh
   ```
3. **Run the Script with Root Privileges:**
   ```bash
   sudo ./official.sh
   ```
   *Note: Running as root enables additional features such as system-level cron integration and systemd services.*

## Usage

After installation, launch the script and you'll be greeted with a handy menu offering various options:
- **Add Custom Command** 🔄: Add new commands tailored to your needs.
- **Edit Commands** ✏️: Modify existing commands.
- **Auto-Run & Scheduling** 🕒: Set up commands to run automatically at boot or on a schedule.
- **System Health Check** 🚑: Perform diagnostics to ensure everything runs smoothly.

Navigate through the menu to explore all available options!

## FAQ

**Q: What Linux distributions are supported?**  
A: The script works on most modern Linux distributions including Ubuntu, Debian, Fedora, Arch, and Termux on Android.

**Q: Do I need root privileges to run Awesome Script?**  
A: No, you can run it in unrooted mode. However, some advanced features require root access.

**Q: How do I update dependencies?**  
A: Keep your system updated using your package manager (e.g., `sudo apt update && sudo apt upgrade` for Ubuntu/Debian or `pkg update && pkg upgrade` for Termux).

**Q: Where can I ask for help if I encounter issues?**  
A: Visit our [GitHub Issues](https://github.com/zynthera/Awesome-Script/issues) page to open a support request or search for similar issues.

**Q: Can I contribute to Awesome Script?**  
A: Absolutely! Please refer to the [Contributing](#contributing) section below for details.

## Contributing 🤝

Contributions are always welcome!  
1. **Fork the repository.**
2. **Create your feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Commit your changes with a descriptive message:**
   ```bash
   git commit -m "Description of your feature"
   ```
4. **Push to your branch:**
   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open a pull request on GitHub.**

Let's build something amazing together!

## License 📄

This project is licensed under the [MIT License](./LICENCE).

## Contact & Support 💬

For questions, support, or feedback, feel free to reach out via [GitHub Issues](https://github.com/zynthera/Awesome-Script/issues) or connect with us on Instagram at [@xploit.ninja](https://instagram.com/xploit.ninja).