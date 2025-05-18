#!/bin/bash

# Script: officail.sh
# Purpose: Ultimate hacker CLI tool with real-time notifications, command chaining, and forensic evasion
# Author: XploitNinjaOfficial (Instagram: @xploit.ninja)


# Configuration
CONFIG_DIR="$HOME/.hacker_customizer"
CONFIG_FILE="$CONFIG_DIR/config.json.gpg"
CONFIG_TEMP="$CONFIG_DIR/config.json"
LOG_FILE="$CONFIG_DIR/script.log"
CMD_LOG="$CONFIG_DIR/command_output.log"
COMMAND_DIR="$CONFIG_DIR/commands"
HISTORY_FILE="$CONFIG_DIR/history"
BACKUP_DIR="$HOME/HackerBackups"
NOTIFY_QUEUE="/tmp/hacker_notify_queue"
DEBUG_MODE=0

# Environment detection
DISTRO="unknown"
if [ -d "/data/data/com.termux" ]; then
    ENV="termux"
    NOTIFY="termux-toast"
    STORAGE_DIR="/sdcard"
    DISTRO="termux"
elif [ -f "/etc/os-release" ]; then
    DISTRO=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    ENV="linux"
    NOTIFY="notify-send"
    STORAGE_DIR="$HOME"
else
    ENV="linux"
    NOTIFY="echo"
    STORAGE_DIR="$HOME"
fi
BACKUP_DIR="$STORAGE_DIR/HackerBackups"

# Root detection
ROOT_USER=0
[ "$(id -u)" -eq 0 ] && ROOT_USER=1

# Hacker aesthetic
export NEWT_COLORS='root=,black window=black,red border=red,black title=red,black textbox=red,black button=black,red'
if [ "$ENV" = "termux" ]; then
    echo "background=#000000" > "$HOME/.termux/termux.properties"
    echo "foreground=#FF0000" >> "$HOME/.termux/termux.properties"
    termux-reload-settings
else
    echo -e "\033[40m\033[31m"
fi

# Ensure directories and files exist
mkdir -p "$CONFIG_DIR" "$COMMAND_DIR" "$BACKUP_DIR"
touch "$LOG_FILE" "$HISTORY_FILE" "$CMD_LOG" "$NOTIFY_QUEUE"

# Initialize config if empty
if [ ! -f "$CONFIG_FILE" ]; then
    echo '{"commands":{},"categories":{},"auto_run":"none","theme":"hacker","favorites":[],"stealth":false,"password":"","tor_enabled":false,"proxies":[],"timeout":300}' | gpg --symmetric --cipher-algo AES256 -o "$CONFIG_FILE" || { echo "Failed to initialize config"; exit 1; }
fi

# Decrypt config
decrypt_config() {
    [ -f "$CONFIG_TEMP" ] && return
    gpg -d "$CONFIG_FILE" 2>/dev/null > "$CONFIG_TEMP" || { send_notification "Failed to decrypt config!"; exit 1; }
}

# Encrypt config
encrypt_config() {
    [ -f "$CONFIG_TEMP" ] || return
    gpg --symmetric --cipher-algo AES256 -o "$CONFIG_FILE" "$CONFIG_TEMP" && rm "$CONFIG_TEMP" || { send_notification "Failed to encrypt config!"; exit 1; }
}

# Password protection
check_password() {
    decrypt_config
    local stored_pass=$(jq -r '.password' "$CONFIG_TEMP")
    if [ -n "$stored_pass" ]; then
        pass=$(whiptail --passwordbox "Enter script password:" 8 40 3>&1 1>&2 2>&3)
        [ "$(echo -n "$pass" | sha256sum | cut -d' ' -f1)" != "$stored_pass" ] && { send_notification "Incorrect password!"; exit 1; }
    else
        pass=$(whiptail --passwordbox "Set script password (leave empty for none):" 8 40 3>&1 1>&2 2>&3)
        if [ -n "$pass" ]; then
            jq ".password = \"$(echo -n "$pass" | sha256sum | cut -d' ' -f1)\"" "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP" || { send_notification "Failed to set password!"; exit 1; }
        fi
    fi
}

# Real-time notification
send_notification() {
    local msg="$1"
    echo "$msg" >> "$NOTIFY_QUEUE"
    while IFS= read -r line; do
        if [ "$NOTIFY" = "termux-toast" ]; then
            $NOTIFY "$line"
        elif [ "$NOTIFY" = "notify-send" ]; then
            $NOTIFY "Hacker Customizer" "$line"
        else
            echo "$line"
        fi
        sleep 1
    done < "$NOTIFY_QUEUE"
    > "$NOTIFY_QUEUE"
    log_message "Notification: $msg by XploitNinjaOfficial"
}

# Logging function
log_message() {
    local stealth=$(jq -r '.stealth' "$CONFIG_TEMP")
    [ "$stealth" = "false" ] && echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    [ $DEBUG_MODE -eq 1 ] && echo "[DEBUG] $1" >> "$LOG_FILE"
}

# Check dependencies
check_dependencies() {
    local deps=("whiptail" "jq" "fzf" "gpg" "figlet" "tor" "proxychains" "nmap" "tcpdump" "iftop")
    local pkg_manager=""
    case "$DISTRO" in
        termux) pkg_manager="pkg install" ;;
        ubuntu|debian|kali) pkg_manager="apt install -y" ;;
        arch|manjaro) pkg_manager="pacman -S --noconfirm" ;;
        fedora) pkg_manager="dnf install -y" ;;
        *) pkg_manager="echo 'Manual install required for'" ;;
    esac
    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null; then
            send_notification "Installing $cmd..."
            $pkg_manager "$cmd" 2>/dev/null || { log_message "Failed to install $cmd"; send_notification "Failed to install $cmd"; exit 1; }
        fi
    done
    [ "$ENV" = "termux" ] && $pkg_manager termux-api 2>/dev/null
}

# Validate cron schedule
validate_cron() {
    local schedule="$1"
    if [[ ! "$schedule" =~ ^[0-9*]+[[:space:]][0-9*]+[[:space:]][0-9*]+[[:space:]][0-9*]+[[:space:]][0-9*]+$ ]]; then
        send_notification "Invalid cron schedule!"
        return 1
    fi
    return 0
}

# Device details
show_device_details() {
    local details=""
    details+="OS: $( [ -f /etc/os-release ] && grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"' || echo 'Unknown' )\n"
    details+="Kernel: $(uname -r)\n"
    details+="CPU: $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)\n"
    details+="Memory: $(free -h | grep Mem | awk '{print $2}') total, $(free -h | grep Mem | awk '{print $3}') used\n"
    details+="Storage: $(df -h / | tail -1 | awk '{print $2}') total, $(df -h / | tail -1 | awk '{print $3}') used\n"
    details+="Interfaces: $(ip link show | grep '^[0-9]' | cut -d: -f2 | xargs)\n"
    details+="IP: $(ip addr show | grep inet | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1 | xargs)\n"
    details+="$(check_tor_status)"
    whiptail --title "Device Details" --msgbox "$details" 15 60 || send_notification "Failed to show device details"
}

# Tor service management
manage_tor() {
    local action=$1
    if [ "$action" = "start" ]; then
        if [ "$ENV" = "termux" ]; then
            tor &>/dev/null &
        else
            [ $ROOT_USER -eq 0 ] && { send_notification "Starting Tor requires root!"; return 1; }
            systemctl start tor || { send_notification "Failed to start Tor!"; return 1; }
        fi
        sleep 2
        if ! pgrep tor >/dev/null; then
            send_notification "Failed to start Tor!"
            return 1
        fi
        send_notification "Tor service started!"
        log_message "Started Tor service"
    elif [ "$action" = "stop" ]; then
        if [ "$ENV" = "termux" ]; then
            pkill tor
        else
            [ $ROOT_USER -eq 0 ] && { send_notification "Stopping Tor requires root!"; return 1; }
            systemctl stop tor
        fi
        send_notification "Tor service stopped!"
        log_message "Stopped Tor service"
    elif [ "$action" = "new_identity" ]; then
        echo -e "AUTHENTICATE\nSIGNAL NEWNYM\nQUIT" | nc 127.0.0.1 9051 || { send_notification "Failed to request new Tor identity!"; return 1; }
        send_notification "Tor new identity requested!"
        log_message "Requested new Tor identity"
    fi
    return 0
}

# Check Tor status
check_tor_status() {
    if pgrep tor >/dev/null; then
        curl --socks5 127.0.0.1:9050 https://check.torproject.org/api/ip 2>/dev/null | jq -r '.IsTor' > /tmp/tor_status
        [ "$(cat /tmp/tor_status)" = "true" ] && echo "Tor: Connected (Exit: $(curl --socks5 127.0.0.1:9050 https://check.torproject.org/api/ip 2>/dev/null | jq -r '.IP'))" || echo "Tor: Running but not connected"
    else
        echo "Tor: Not running"
    fi
}

# Timestamp manipulation
manipulate_timestamp() {
    local file="$1"
    local days=$((RANDOM % 7 + 1))
    local timestamp=$(date -d "-$days days" +%Y%m%d%H%M.%S)
    touch -t "$timestamp" "$file" || { send_notification "Failed to manipulate timestamp for $file"; return 1; }
    send_notification "Timestamp for $file set to $timestamp"
    log_message "Manipulated timestamp for $file to $timestamp"
}

# Main menu
show_menu() {
    decrypt_config
    whiptail --title "Hacker Customizer by XploitNinjaOfficial" --menu "Choose an option:" 28 60 18 \
        "1" "Add Custom Command" \
        "2" "Edit Commands" \
        "3" "Set Auto-Run" \
        "4" "Configure Theme" \
        "5" "Backup/Restore Config" \
        "6" "Run Favorite Commands" \
        "7" "View Command History" \
        "8" "Run Multiple Commands" \
        "9" "Toggle Stealth Mode" \
        "10" "Network Monitor" \
        "11" "Generate Payload" \
        "12" "Clean Logs" \
        "13" "Remote Execution" \
        "14" "Tor Service Control" \
        "15" "System Health Check" \
        "16" "Forensic Evasion" \
        "17" "Manage Proxies" \
        "18" "Help Menu" \
        "19" "Exit" 2> /tmp/choice
    choice=$(cat /tmp/choice)
    rm /tmp/choice
    case $choice in
        1) add_command ;;
        2) edit_commands ;;
        3) set_auto_run ;;
        4) configure_theme ;;
        5) backup_restore ;;
        6) run_favorites ;;
        7) view_history ;;
        8) run_multiple ;;
        9) toggle_stealth ;;
        10) network_monitor ;;
        11) generate_payload ;;
        12) clean_logs ;;
        13) remote_execution ;;
        14) tor_control ;;
        15) system_health ;;
        16) forensic_evasion ;;
        17) manage_proxies ;;
        18) show_help ;;
        19) encrypt_config; manage_tor stop; exit 0 ;;
    esac
    encrypt_config
}

# Add a custom command
add_command() {
    category=$(whiptail --inputbox "Enter category (e.g., Recon, Exploit):" 8 40 2>&1 >/dev/tty)
    [ -z "$category" ] && category="General"
    name=$(whiptail --inputbox "Enter command name:" 8 40 2>&1 >/dev/tty)
    [ -z "$name" ] && { send_notification "Name cannot be empty!"; return; }
    cmd=$(whiptail --inputbox "Enter command (e.g., nmap -sV 192.168.1.0/24 | grep open):" 8 40 2>&1 >/dev/tty)
    [ -z "$cmd" ] && { send_notification "Command cannot be empty!"; return; }
    
    # Suggest commands
    suggestions=("nmap -sC -sV 192.168.1.0/24 | grep open" "sqlmap -u http://example.com --dbs" "msfvenom -p windows/meterpreter/reverse_tcp" "proxychains nmap -sT 192.168.1.0/24 | awk '/open/'")
    if whiptail --yesno "Use a suggested command?" 8 40; then
        cmd=$(printf '%s\n' "${suggestions[@]}" | fzf --prompt="Select suggested command: ")
    fi

    # Test command
    if whiptail --yesno "Test command before saving?" 8 40; then
        timeout $(jq -r '.timeout' "$CONFIG_TEMP") bash -c "$cmd" > /tmp/cmd_test 2>&1
        if [ $? -eq 0 ]; then
            whiptail --textbox /tmp/cmd_test 15 60
        else
            send_notification "Command test failed!"
            return
        fi
    fi

    # Check root requirement
    if [[ "$cmd" =~ ^(sudo|ufw|iptables|airmon-ng|airodump-ng|tcpdump) ]] && [ $ROOT_USER -eq 0 ]; then
        whiptail --msgbox "Warning: '$cmd' may require root privileges!" 8 40
    fi

    # Validate command
    if ! bash -n -c "$cmd" 2>/dev/null; then
        send_notification "Invalid command syntax!"
        return
    fi

    # Tor routing option
    if jq -r '.tor_enabled' "$CONFIG_TEMP" | grep -q true && whiptail --yesno "Route command through Tor?" 8 40; then
        cmd="torify $cmd"
    fi

    # Obfuscate option
    if whiptail --yesno "Obfuscate command script?" 8 40; then
        if command -v shc >/dev/null; then
            echo "$cmd" > "$COMMAND_DIR/$category-$name.sh"
            shc -f "$COMMAND_DIR/$category-$name.sh" -o "$COMMAND_DIR/$category-$name" 2>/dev/null || { send_notification "Failed to obfuscate command!"; return; }
            rm "$COMMAND_DIR/$category-$name.sh" "$COMMAND_DIR/$category-$name.sh.x.c" 2>/dev/null
            cmd="$COMMAND_DIR/$category-$name"
        else
            cmd="echo \"$(echo "$cmd" | base64)\" | base64 -d | bash"
        fi
    fi

    # Store in JSON
    jq ".commands.\"$category\".\"$name\" = \"$cmd\"" "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP" || { send_notification "Failed to save command!"; return; }
    jq ".categories.\"$category\" += [\"$name\"]" "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP"
    if [[ ! "$cmd" =~ ^$COMMAND_DIR ]]; then
        echo "#!/bin/bash" > "$COMMAND_DIR/$category-$name.sh"
        echo "$cmd" >> "$COMMAND_DIR/$category-$name.sh"
        chmod +x "$COMMAND_DIR/$category-$name.sh"
    fi
    send_notification "Command '$name' added to '$category'!"
    log_message "Added command: $category/$name by XploitNinjaOfficial"
}

# Edit commands
edit_commands() {
    category=$(jq -r '.commands | keys[]' "$CONFIG_TEMP" | fzf --prompt="Select category: ")
    [ -z "$category" ] && return
    commands=$(jq -r ".commands.\"$category\" | keys[]" "$CONFIG_TEMP" | fzf --prompt="Select command to edit: ")
    [ -z "$commands" ] && return
    cmd=$(jq -r ".commands.\"$category\".\"$commands\"" "$CONFIG_TEMP")
    new_cmd=$(whiptail --inputbox "Edit command '$commands':" 8 40 "$cmd" 2>&1 >/dev/tty)
    if [ -n "$new_cmd" ] && bash -n -c "$new_cmd" 2>/dev/null; then
        jq ".commands.\"$category\".\"$commands\" = \"$new_cmd\"" "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP" || { send_notification "Failed to update command!"; return; }
        echo "#!/bin/bash" > "$COMMAND_DIR/$category-$commands.sh"
        echo "$new_cmd" >> "$COMMAND_DIR/$category-$commands.sh"
        chmod +x "$COMMAND_DIR/$category-$commands.sh"
        send_notification "Command '$commands' updated!"
        log_message "Updated command: $category/$commands"
    else
        send_notification "Invalid command syntax!"
    fi
}

# Set auto-run
set_auto_run() {
    whiptail --title "Auto-Run Setup" --menu "Choose auto-run option:" 15 50 4 \
        "1" "Run on Boot" \
        "2" "Schedule with Cron" \
        "3" "Schedule with Anacron" \
        "4" "Disable Auto-Run" 2> /tmp/auto_choice
    choice=$(cat /tmp/auto_choice)
    rm /tmp/auto_choice
    case $choice in
        1)
            category=$(jq -r '.commands | keys[]' "$CONFIG_TEMP" | fzf --prompt="Select category: ")
            [ -z "$category" ] && return
            cmd=$(jq -r ".commands.\"$category\" | keys[]" "$CONFIG_TEMP" | fzf --prompt="Select command for boot: ")
            [ -z "$cmd" ] && return
            if [ "$ENV" = "termux" ]; then
                mkdir -p "$HOME/.termux/boot"
                echo "#!/data/data/com.termux/files/usr/bin/bash" > "$HOME/.termux/boot/custom_run.sh"
                echo "$COMMAND_DIR/$category-$cmd.sh" >> "$HOME/.termux/boot/custom_run.sh"
                chmod +x "$HOME/.termux/boot/custom_run.sh"
            elif [ "$DISTRO" = "gentoo" ]; then
                [ $ROOT_USER -eq 0 ] && { send_notification "Root required for OpenRC setup!"; return; }
                echo "#!/sbin/openrc-run" > /etc/init.d/hacker-customizer
                echo "command=$COMMAND_DIR/$category-$cmd.sh" >> /etc/init.d/hacker-customizer
                chmod +x /etc/init.d/hacker-customizer
                rc-update add hacker-customizer default
            else
                [ $ROOT_USER -eq 0 ] && { send_notification "Root required for systemd setup!"; return; }
                cat <<EOF > /etc/systemd/system/hacker-customizer.service
[Unit]
Description=Hacker Customizer Boot Script
After=network.target

[Service]
ExecStart=$COMMAND_DIR/$category-$cmd.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
                systemctl enable hacker-customizer.service || { send_notification "Failed to enable systemd service!"; return; }
            fi
            jq '.auto_run = "boot"' "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP"
            send_notification "Set '$cmd' to run on boot!"
            log_message "Set auto-run on boot: $category/$cmd"
            ;;
        2)
            category=$(jq -r '.commands | keys[]' "$CONFIG_TEMP" | fzf --prompt="Select category: ")
            [ -z "$category" ] && return
            cmd=$(jq -r ".commands.\"$category\" | keys[]" "$CONFIG_TEMP" | fzf --prompt="Select command for cron: ")
            [ -z "$cmd" ] && return
            schedule=$(whiptail --inputbox "Enter cron schedule (e.g., '0 * * * *' for hourly):" 8 40 2>&1 >/dev/tty)
            if [ -n "$schedule" ] && validate_cron "$schedule"; then
                crontab -l > /tmp/crontab 2>/dev/null
                echo "$schedule $COMMAND_DIR/$category-$cmd.sh" >> /tmp/crontab
                crontab /tmp/crontab || { send_notification "Failed to set cron job!"; return; }
                rm /tmp/crontab
                jq '.auto_run = "cron"' "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP"
                send_notification "Scheduled '$cmd' with cron!"
                log_message "Scheduled cron: $category/$cmd"
            fi
            ;;
        3)
            [ $ROOT_USER -eq 0 ] && { send_notification "Root required for anacron setup!"; return; }
            category=$(jq -r '.commands | keys[]' "$CONFIG_TEMP" | fzf --prompt="Select category: ")
            [ -z "$category" ] && return
            cmd=$(jq -r ".commands.\"$category\" | keys[]" "$CONFIG_TEMP" | fzf --prompt="Select command for anacron: ")
            [ -z "$cmd" ] && return
            period=$(whiptail --inputbox "Enter anacron period (e.g., '1' for daily):" 8 40 2>&1 >/dev/tty)
            if [ -n "$period" ]; then
                echo "$period 0 hacker-customizer $COMMAND_DIR/$category-$cmd.sh" > /etc/anacrontab || { send_notification "Failed to set anacron job!"; return; }
                jq '.auto_run = "anacron"' "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP"
                send_notification "Scheduled '$cmd' with anacron!"
                log_message "Scheduled anacron: $category/$cmd"
            fi
            ;;
        4)
            [ "$ENV" = "termux" ] && rm -rf "$HOME/.termux/boot/custom_run.sh"
            [ "$ENV" = "linux" ] && {
                systemctl disable hacker-customizer.service 2>/dev/null
                rm /etc/init.d/hacker-customizer 2>/dev/null
            }
            crontab -r 2>/dev/null
            jq '.auto_run = "none"' "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP"
            send_notification "Auto-run disabled!"
            log_message "Disabled auto-run"
            ;;
    esac
}

# Configure theme
configure_theme() {
    whiptail --title "Theme Configuration" --msgbox "Hacker theme (black/red) applied by XploitNinjaOfficial. Customize further in terminal settings." 8 40
    jq '.theme = "hacker"' "$CONFIG_TEMP" > "$CONFIG_TEMP.tmp" && mv "$CONFIG_TEMP.tmp" "$CONFIG_TEMP"
    send_notification "Hacker theme applied by XploitNinjaOfficial"
    log_message "Applied hacker theme by XploitNinjaOfficial"
}

# Backup and restore
backup_restore() {
    whiptail --title "Backup/Restore" --menu "Choose option:" 10 40 3 \
        "1" "Backup Config" \
        "2" "Restore Config" \
        "3" "Back" 2> /tmp/backup_choice
    choice=$(cat /tmp/backup_choice)
    rm /tmp/backup_choice
    case $choice in
        1)
            timestamp=$(date '+%Y%m%d_%H%M%S')
            cp "$CONFIG_FILE" "$BACKUP_DIR/hacker_config_$timestamp.json.gpg" || { send_notification "Failed to backup config!"; return; }
            tar -czf "$BACKUP_DIR/hacker_commands_$timestamp.tar.gz" "$COMMAND_DIR" || { send_notification "Failed to backup commands!"; return; }
            send_notification "Backup created in $BACKUP_DIR!"
            log_message "Created backup: hacker_config_$timestamp"
            ;;
        2)
            backup=$(ls "$BACKUP_DIR"/*.json.gpg | fzf --prompt="Select backup to restore: ")
            if [ -n "$backup" ]; then
                cp "$backup" "$CONFIG_FILE" || { send_notification "Failed to restore config!"; return; }
                tar -xzf "${backup%.json.gpg}.tar.gz" -C "$CONFIG_D