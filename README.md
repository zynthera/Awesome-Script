# Awesome Script 🚀💻

[![GitHub Repo stars](https://img.shields.io/github/stars/zynthera/Awesome-Script?style=social)](https://github.com/zynthera/Awesome-Script/stargazers)
[![GitHub Repo forks](https://img.shields.io/github/forks/zynthera/Awesome-Script?style=social)](https://github.com/zynthera/Awesome-Script/network/members)
[![Visitors](https://visitor-badge.laobi.icu/badge?page_id=zynthera/Awesome-Script)](https://github.com/zynthera/Awesome-Script)

Welcome to **Awesome Script**! 😎✨  
This repository houses the ultimate Hacker CLI tool with real-time notifications, command chaining, and forensic evasion. Whether you're running it under a root or non-root environment, our installation and configuration guide will help you set up the tool effortlessly on any Linux distribution.

## Table of Contents
- [Features](#features)
- [Installation Guide](#installation-guide)
  - [Requirements](#requirements)
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
  Compatible with various Linux distros, whether you're operating as root or a regular user.
  
- **Secure Config Management** 🔐  
  Encrypted configuration and password protection to keep your operations safe.
  
- **Automated Backups & Cron Scheduling** ⏰  
  Keep your environment up-to-date with automated tasks.

## Installation Guide

Below you will find step-by-step instructions to install **Awesome Script** on your Linux machine. We provide two sections: one for unrooted users and one for root users. Both will work on common distributions like Ubuntu, Debian, Fedora, Arch, and more.

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

### Installation for Unrooted Users
1. **Clone the Repository**  
   ```bash
   git clone https://github.com/zynthera/Awesome-Script.git
   cd Awesome-Script
   ```
2. **Make the Script Executable**  
   ```bash
   chmod +x official.sh
   ```
3. **Run the Script**  
   Simply execute the script:
   ```bash
   ./official.sh
   ```
   - The script will run in user mode. Some advanced features, such as system-wide cron jobs or initializing systemd services, may be limited.

### Installation for Root Users
1. **Clone the Repository**  
   ```bash
   git clone https://github.com/zynthera/Awesome-Script.git
   cd Awesome-Script
   ```
2. **Make the Script Executable**  
   ```bash
   sudo chmod +x official.sh
   ```
3. **Run the Script with Root Privileges**  
   Execute the script as root for full functionality:
   ```bash
   sudo ./official.sh
   ```
   - Running as root enables additional features such as system-level cron integration and managing services with systemd.

## Usage

After installation, launch the script and you'll be greeted with a handy menu offering a range of options:
- **Add Custom Command** 🔄: Add new commands to tailor the script to your needs.
- **Edit Commands** ✏️: Modify existing commands.
- **Auto-Run & Scheduling** 🕒: Set up commands to run automatically at boot or on a schedule.
- **System Health Check** 🚑: Perform diagnostics to ensure everything is running smoothly.

Explore all available options by navigating through the menu!

## FAQ

**Q: What Linux distributions are supported?**  
A: The script works on most modern Linux distributions including Ubuntu, Debian, Fedora, Arch, and more. Specific installation commands may vary depending on your package manager.

**Q: Do I need root privileges to run Awesome Script?**  
A: No, you can run it in unrooted mode. However, some features like systemd service integration or global cron setups may require root access.

**Q: How do I update dependencies?**  
A: Ensure you keep your system updated using your package manager (e.g., `sudo apt update && sudo apt upgrade` for Ubuntu/Debian).

**Q: The script requires multiple dependencies; how can I ensure they are all installed correctly?**  
A: The installation guide includes commands for installing all required dependencies. In case of any missing package, please install it manually using your package manager.

**Q: I encountered an error while running the script. Where can I ask for help?**  
A: Visit our [GitHub Issues](https://github.com/zynthera/Awesome-Script/issues) page to open a new support request or to search for similar issues.

**Q: Can I contribute to Awesome Script?**  
A: Absolutely! Please refer to the [Contributing](#contributing) section below for more details.

## Contributing 🤝

Contributions are always welcome!  
1. Fork the repository.  
2. Create your feature branch:  
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes with a descriptive message:  
   ```bash
   git commit -m "Description of your feature"
   ```
4. Push to your branch:  
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request on GitHub.

Let's build something amazing together!

## License 📄

This project is licensed under the [MIT License](./LICENCE).

## Contact & Support 💬

For questions, support, or feedback, feel free to reach out via [GitHub Issues](https://github.com/zynthera/Awesome-Script/issues) or connect with us on Instagram at [@xploit.ninja](https://instagram.com/xploit.ninja).
