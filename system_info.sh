#!/bin/bash

# System information functions

show_system_info() {
    print_header
    echo -e "${COLOR_CYAN}ZeroLinux System Information${COLOR_RESET}"
    echo -e "${COLOR_BLUE}=============================${COLOR_RESET}\n"
    
    # Version
    echo -e "${COLOR_CYAN}Version:${COLOR_RESET} $VERSION"
    
    # Host info
    echo -e "${COLOR_CYAN}Hostname:${COLOR_RESET} $(hostname)"
    echo -e "${COLOR_CYAN}Kernel:${COLOR_RESET} $(uname -r)"
    
    # CPU info
    CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2 | sed 's/^[ \t]*//')
    CORES=$(grep -c processor /proc/cpuinfo)
    echo -e "${COLOR_CYAN}CPU:${COLOR_RESET} $CPU ($CORES cores)"
    
    # Memory info
    TOTAL_MEM=$(free -h | grep Mem | awk '{print $2}')
    USED_MEM=$(free -h | grep Mem | awk '{print $3}')
    FREE_MEM=$(free -h | grep Mem | awk '{print $4}')
    echo -e "${COLOR_CYAN}Memory:${COLOR_RESET} $USED_MEM used of $TOTAL_MEM ($FREE_MEM free)"
    
    # Disk usage
    echo -e "${COLOR_CYAN}Disk usage:${COLOR_RESET}"
    df -h | grep -E '^/dev/' | awk '{print "  " $6 ": " $3 "/" $2 " (" $5 ")"}'
    
    # System uptime
    echo -e "${COLOR_CYAN}Uptime:${COLOR_RESET} $(uptime -p)"
    
    # Network info
    echo -e "${COLOR_CYAN}Network interfaces:${COLOR_RESET}"
    ip -o addr show | grep -v "lo\|host" | awk '{print "  " $2 ": " $4}'
    
    # Installed packages
    PACKAGE_COUNT=$(pacman -Q | wc -l)
    echo -e "${COLOR_CYAN}Installed packages:${COLOR_RESET} $PACKAGE_COUNT"
    
    # Desktop environment
    echo -e "${COLOR_CYAN}Desktop:${COLOR_RESET} $(echo $XDG_CURRENT_DESKTOP)"
    
    echo -e "\n${COLOR_BLUE}=============================${COLOR_RESET}"
}

show_help() {
    print_header
    echo -e "Usage: ${COLOR_CYAN}zero${COLOR_RESET} [command]"
    echo ""
    echo -e "Commands:"
    echo -e "  ${COLOR_GREEN}update${COLOR_RESET}        - Update system and all packages"
    echo -e "  ${COLOR_GREEN}install${COLOR_RESET}       - Install packages"
    echo -e "  ${COLOR_GREEN}remove${COLOR_RESET}        - Remove packages"
    echo -e "  ${COLOR_GREEN}clean${COLOR_RESET}         - Clean package cache"
    echo -e "  ${COLOR_GREEN}security${COLOR_RESET}      - Install security tools"
    echo -e "  ${COLOR_GREEN}dev${COLOR_RESET}           - Install development tools"
    echo -e "  ${COLOR_GREEN}network${COLOR_RESET}       - Install networking tools"
    echo -e "  ${COLOR_GREEN}theme${COLOR_RESET}         - Manage system themes"
    echo -e "  ${COLOR_GREEN}system${COLOR_RESET}        - Show system information"
    echo -e "  ${COLOR_GREEN}troubleshoot${COLOR_RESET}  - System troubleshooting tools"
    echo -e "  ${COLOR_GREEN}help${COLOR_RESET}          - Show this help"
    echo ""
} 