#!/bin/bash

# Version information
VERSION="1.0"

# Color definitions
COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_CYAN='\033[0;36m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_RESET='\033[0m'

# ASCII Art Logo
LOGO="
${COLOR_CYAN}▒███████▒${COLOR_GREEN}▓█████  ${COLOR_CYAN}██▀███   ${COLOR_GREEN}▒█████   ${COLOR_CYAN}██▓     ${COLOR_GREEN}██▓ ${COLOR_CYAN}███▄    █  ${COLOR_GREEN}█    ██ ${COLOR_CYAN}▒██   ██▒
${COLOR_CYAN}▒ ▒ ▒ ▄▀░${COLOR_GREEN}▓█   ▀ ${COLOR_CYAN}▓██ ▒ ██▒${COLOR_GREEN}▒██▒  ██▒${COLOR_CYAN}▓██▒    ${COLOR_GREEN}▓██▒${COLOR_CYAN} ██ ▀█   █ ${COLOR_GREEN} ██  ▓██▒${COLOR_CYAN}▒▒ █ █ ▒░
${COLOR_CYAN}░ ▒ ▄▀▒░ ${COLOR_GREEN}▒███   ${COLOR_CYAN}▓██ ░▄█ ▒${COLOR_GREEN}▒██░  ██▒${COLOR_CYAN}▒██░    ${COLOR_GREEN}▒██▒${COLOR_CYAN}▓██  ▀█ ██▒${COLOR_GREEN}▓██  ▒██░${COLOR_CYAN}░░  █   ░
${COLOR_CYAN}  ▄▀▒   ░${COLOR_GREEN}▒▓█  ▄ ${COLOR_CYAN}▒██▀▀█▄  ${COLOR_GREEN}▒██   ██░${COLOR_CYAN}▒██░    ${COLOR_GREEN}░██░${COLOR_CYAN}▓██▒  ▐▌██▒${COLOR_GREEN}▓▓█  ░██░${COLOR_CYAN} ░ █ █ ▒ 
${COLOR_CYAN}▒███████▒${COLOR_GREEN}░▒████▒${COLOR_CYAN}░██▓ ▒██▒${COLOR_GREEN}░ ████▓▒░${COLOR_CYAN}░██████▒${COLOR_GREEN}░██░${COLOR_CYAN}▒██░   ▓██░${COLOR_GREEN}▒▒█████▓ ${COLOR_CYAN}▒██▒ ▒██▒
${COLOR_CYAN}░▒▒ ▓░▒░▒${COLOR_GREEN}░░ ▒░ ░${COLOR_CYAN}░ ▒▓ ░▒▓░${COLOR_GREEN}░ ▒░▒░▒░ ${COLOR_CYAN}░ ▒░▓  ░${COLOR_GREEN}░▓  ${COLOR_CYAN}░ ▒░   ▒ ▒ ${COLOR_GREEN}░▒▓▒ ▒ ▒ ${COLOR_CYAN}▒▒ ░ ░▓ ░
${COLOR_CYAN}░░▒ ▒ ░ ▒${COLOR_GREEN} ░ ░  ░${COLOR_CYAN}  ░▒ ░ ▒░${COLOR_GREEN}  ░ ▒ ▒░ ${COLOR_CYAN}░ ░ ▒  ░${COLOR_GREEN} ▒ ░${COLOR_CYAN}░ ░░   ░ ▒░${COLOR_GREEN}░░▒░ ░ ░ ${COLOR_CYAN}░░   ░▒ ░
${COLOR_CYAN}░ ░ ░ ░ ░${COLOR_GREEN}   ░   ${COLOR_CYAN}  ░░   ░ ${COLOR_GREEN}░ ░ ░ ▒  ${COLOR_CYAN}  ░ ░   ${COLOR_GREEN} ▒ ░${COLOR_CYAN}   ░   ░ ░ ${COLOR_GREEN} ░░░ ░ ░ ${COLOR_CYAN} ░    ░  
${COLOR_CYAN}  ░ ░    ${COLOR_GREEN}   ░  ░${COLOR_CYAN}   ░     ${COLOR_GREEN}    ░ ░  ${COLOR_CYAN}    ░  ░${COLOR_GREEN} ░  ${COLOR_CYAN}        ░  ${COLOR_GREEN}   ░     ${COLOR_CYAN}  ░    ░  
${COLOR_CYAN}░        ${COLOR_GREEN}        ${COLOR_CYAN}         ${COLOR_GREEN}         ${COLOR_CYAN}         ${COLOR_GREEN}    ${COLOR_CYAN}           ${COLOR_GREEN}         ${COLOR_CYAN}         
${COLOR_RESET}"

# Helper functions
print_header() {
    clear
    echo -e "$LOGO"
    echo -e "${COLOR_CYAN}ZeroLinux Management Tool v$VERSION${COLOR_RESET}"
    echo -e "${COLOR_BLUE}=============================================${COLOR_RESET}\n"
}

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while ps -p $pid > /dev/null; do
        for i in $(seq 0 3); do
            echo -ne "\r${COLOR_CYAN}[${spinstr:$i:1}]${COLOR_RESET} $2"
            sleep $delay
        done
    done
    echo -e "\r${COLOR_GREEN}[✓]${COLOR_RESET} $2"
}

# Error handling
error_exit() {
    echo -e "${COLOR_RED}Error: $1${COLOR_RESET}" >&2
    exit 1
}

# Check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        error_exit "This script must be run as root"
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if package is installed
package_installed() {
    pacman -Q "$1" >/dev/null 2>&1
} 