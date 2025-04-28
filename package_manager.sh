#!/bin/bash

# Package management functions

update_system() {
    print_header
    echo -e "${COLOR_CYAN}Updating ZeroLinux system...${COLOR_RESET}\n"
    
    check_root
    
    echo -e "${COLOR_YELLOW}Synchronizing package databases...${COLOR_RESET}"
    sudo pacman -Sy &
    spinner $! "Synchronizing package databases"
    
    echo -e "\n${COLOR_YELLOW}Upgrading all packages...${COLOR_RESET}"
    sudo pacman -Su
    
    echo -e "\n${COLOR_GREEN}System update completed!${COLOR_RESET}"
}

install_pkg() {
    if [ -z "$1" ]; then
        print_header
        echo -e "${COLOR_RED}Please specify package(s) to install${COLOR_RESET}"
        echo -e "Usage: ${COLOR_CYAN}zero install ${COLOR_GREEN}package_name1 package_name2...${COLOR_RESET}"
        return 1
    fi
    
    check_root
    
    print_header
    echo -e "${COLOR_CYAN}Installing packages: ${COLOR_GREEN}$@${COLOR_RESET}\n"
    sudo pacman -S "$@"
    
    echo -e "\n${COLOR_GREEN}Installation completed!${COLOR_RESET}"
}

remove_pkg() {
    if [ -z "$1" ]; then
        print_header
        echo -e "${COLOR_RED}Please specify package(s) to remove${COLOR_RESET}"
        echo -e "Usage: ${COLOR_CYAN}zero remove ${COLOR_GREEN}package_name1 package_name2...${COLOR_RESET}"
        return 1
    fi
    
    check_root
    
    print_header
    echo -e "${COLOR_CYAN}Removing packages: ${COLOR_RED}$@${COLOR_RESET}\n"
    sudo pacman -Rs "$@"
    
    echo -e "\n${COLOR_GREEN}Removal completed!${COLOR_RESET}"
}

clean_system() {
    print_header
    echo -e "${COLOR_CYAN}Cleaning ZeroLinux system...${COLOR_RESET}\n"
    
    check_root
    
    echo -e "${COLOR_YELLOW}Cleaning package cache...${COLOR_RESET}"
    sudo pacman -Sc --noconfirm &
    spinner $! "Cleaning package cache"
    
    echo -e "\n${COLOR_YELLOW}Removing orphaned packages...${COLOR_RESET}"
    ORPHANS=$(pacman -Qtdq)
    if [ -z "$ORPHANS" ]; then
        echo -e "${COLOR_GREEN}No orphaned packages found.${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}Found orphaned packages:${COLOR_RESET} $ORPHANS"
        sudo pacman -Rns $(pacman -Qtdq) --noconfirm &
        spinner $! "Removing orphaned packages"
    fi
    
    echo -e "\n${COLOR_YELLOW}Clearing systemd journal logs...${COLOR_RESET}"
    sudo journalctl --vacuum-time=1weeks &
    spinner $! "Clearing systemd journal logs"
    
    echo -e "\n${COLOR_GREEN}System cleaning completed!${COLOR_RESET}"
}

install_security_tools() {
    print_header
    echo -e "${COLOR_CYAN}Installing security tools...${COLOR_RESET}\n"
    
    check_root
    
    TOOLS=(
        "nmap"                # Network scanning
        "wireshark-qt"        # Packet analyzer
        "metasploit"          # Penetration testing
        "burpsuite"           # Web security testing
        "aircrack-ng"         # Wireless security
        "nikto"               # Web server scanner
        "hashcat"             # Password cracking
        "john"                # Password cracking
        "lynis"               # Security auditing
        "rkhunter"            # Rootkit detection
        "clamav"              # Antivirus
        "fail2ban"            # Intrusion prevention
        "firejail"            # Sandbox
        "openvas"             # Vulnerability scanner
    )
    
    echo -e "The following security tools will be installed:\n"
    for tool in "${TOOLS[@]}"; do
        echo -e "- ${COLOR_GREEN}$tool${COLOR_RESET}"
    done
    
    echo -e "\nDo you want to continue? [Y/n] "
    read -r response
    case "$response" in
        [nN][oO]|[nN]) 
            echo -e "${COLOR_RED}Installation cancelled.${COLOR_RESET}"
            return 1
            ;;
    esac
    
    for tool in "${TOOLS[@]}"; do
        echo -e "\n${COLOR_YELLOW}Installing $tool...${COLOR_RESET}"
        sudo pacman -S --noconfirm "$tool" || echo -e "${COLOR_RED}Failed to install $tool. It might not be available in the repositories.${COLOR_RESET}"
    done
    
    echo -e "\n${COLOR_GREEN}Security tools installation completed!${COLOR_RESET}"
    echo -e "${COLOR_CYAN}You can find these tools in your application menu.${COLOR_RESET}"
}

install_dev_tools() {
    print_header
    echo -e "${COLOR_CYAN}Installing development tools...${COLOR_RESET}\n"
    
    check_root
    
    TOOLS=(
        "git"                 # Version control
        "visual-studio-code-bin" # Code editor
        "atom"                # Code editor
        "sublime-text-dev"    # Code editor
        "docker"              # Container platform
        "docker-compose"      # Container orchestration
        "nodejs"              # JavaScript runtime
        "npm"                 # Node package manager
        "python"              # Python language
        "python-pip"          # Python package manager
        "gcc"                 # C/C++ compiler
        "cmake"               # Build system
        "make"                # Build automation
        "jdk-openjdk"         # Java Development Kit
        "ruby"                # Ruby language
        "go"                  # Go language
        "rust"                # Rust language
        "php"                 # PHP language
        "mariadb"             # Database server
        "postgresql"          # Database server
        "mongodb"             # NoSQL database
        "redis"               # In-memory database
    )
    
    echo -e "The following development tools will be installed:\n"
    for tool in "${TOOLS[@]}"; do
        echo -e "- ${COLOR_GREEN}$tool${COLOR_RESET}"
    done
    
    echo -e "\nDo you want to continue? [Y/n] "
    read -r response
    case "$response" in
        [nN][oO]|[nN]) 
            echo -e "${COLOR_RED}Installation cancelled.${COLOR_RESET}"
            return 1
            ;;
    esac
    
    for tool in "${TOOLS[@]}"; do
        echo -e "\n${COLOR_YELLOW}Installing $tool...${COLOR_RESET}"
        sudo pacman -S --noconfirm "$tool" || echo -e "${COLOR_RED}Failed to install $tool. It might not be available in the repositories.${COLOR_RESET}"
    done
    
    echo -e "\n${COLOR_GREEN}Development tools installation completed!${COLOR_RESET}"
    echo -e "${COLOR_CYAN}You can find these tools in your application menu.${COLOR_RESET}"
}

install_network_tools() {
    print_header
    echo -e "${COLOR_CYAN}Installing networking tools...${COLOR_RESET}\n"
    
    check_root
    
    TOOLS=(
        "tcpdump"             # Packet analyzer
        "iftop"               # Network monitoring
        "ethtool"             # Interface configuration
        "net-tools"           # Network tools
        "wireshark-cli"       # Command-line packet analyzer
        "dsniff"              # Network auditing
        "arpwatch"            # MAC/IP monitoring
        "bmon"                # Bandwidth monitor
        "iptraf-ng"           # Network statistics
        "nethogs"             # Process monitoring
        "traceroute"          # Route tracking
        "whois"               # Domain information
        "bind-tools"          # DNS tools
        "openvpn"             # VPN client
        "openssh"             # SSH client/server
    )
    
    echo -e "The following networking tools will be installed:\n"
    for tool in "${TOOLS[@]}"; do
        echo -e "- ${COLOR_GREEN}$tool${COLOR_RESET}"
    done
    
    echo -e "\nDo you want to continue? [Y/n] "
    read -r response
    case "$response" in
        [nN][oO]|[nN]) 
            echo -e "${COLOR_RED}Installation cancelled.${COLOR_RESET}"
            return 1
            ;;
    esac
    
    for tool in "${TOOLS[@]}"; do
        echo -e "\n${COLOR_YELLOW}Installing $tool...${COLOR_RESET}"
        sudo pacman -S --noconfirm "$tool" || echo -e "${COLOR_RED}Failed to install $tool. It might not be available in the repositories.${COLOR_RESET}"
    done
    
    echo -e "\n${COLOR_GREEN}Networking tools installation completed!${COLOR_RESET}"
    echo -e "${COLOR_CYAN}You can find these tools in your application menu.${COLOR_RESET}"
} 