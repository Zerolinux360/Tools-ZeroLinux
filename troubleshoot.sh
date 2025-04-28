#!/bin/bash

# System troubleshooting functions

system_troubleshoot() {
    print_header
    echo -e "${COLOR_CYAN}ZeroLinux Troubleshooting Tools${COLOR_RESET}\n"
    
    echo -e "1. ${COLOR_GREEN}Check system logs${COLOR_RESET}"
    echo -e "2. ${COLOR_GREEN}Check disk health${COLOR_RESET}"
    echo -e "3. ${COLOR_GREEN}Fix broken packages${COLOR_RESET}"
    echo -e "4. ${COLOR_GREEN}Check system services${COLOR_RESET}"
    echo -e "5. ${COLOR_GREEN}Back to main menu${COLOR_RESET}"
    echo ""
    echo -e "Enter your choice [1-5]: "
    read -r trouble_option
    
    case $trouble_option in
        1) check_system_logs ;;
        2) check_disk_health ;;
        3) fix_broken_packages ;;
        4) check_system_services ;;
        5) return 0 ;;
        *) echo -e "${COLOR_RED}Invalid option${COLOR_RESET}" ;;
    esac
    
    echo -e "\nPress Enter to continue..."
    read -r
    system_troubleshoot
}

check_system_logs() {
    print_header
    echo -e "${COLOR_CYAN}System Logs Analysis${COLOR_RESET}\n"
    
    check_root
    
    echo -e "${COLOR_YELLOW}Checking for errors in journal logs...${COLOR_RESET}\n"
    sudo journalctl -p 3 -b | tail -n 20
    
    echo -e "\n${COLOR_YELLOW}Checking for warnings in journal logs...${COLOR_RESET}\n"
    sudo journalctl -p 4 -b | tail -n 10
    
    echo -e "\n${COLOR_YELLOW}Recent boot logs:${COLOR_RESET}\n"
    sudo journalctl -b | head -n 20
}

check_disk_health() {
    print_header
    echo -e "${COLOR_CYAN}Disk Health Check${COLOR_RESET}\n"
    
    check_root
    
    # Install necessary tools
    if ! command_exists smartctl; then
        echo -e "${COLOR_YELLOW}Installing smartmontools...${COLOR_RESET}"
        sudo pacman -S --noconfirm smartmontools
    fi
    
    # Get list of drives
    DRIVES=$(lsblk -d -o name | grep -v "loop\|NAME")
    
    for drive in $DRIVES; do
        echo -e "\n${COLOR_YELLOW}Checking health of /dev/$drive...${COLOR_RESET}\n"
        sudo smartctl -H /dev/$drive
        echo -e "\n${COLOR_YELLOW}SMART attributes for /dev/$drive:${COLOR_RESET}\n"
        sudo smartctl -A /dev/$drive | head -n 20
    done
    
    echo -e "\n${COLOR_YELLOW}Filesystem check summary:${COLOR_RESET}\n"
    df -Th | grep -v "tmpfs\|loop"
}

fix_broken_packages() {
    print_header
    echo -e "${COLOR_CYAN}Fixing Broken Packages${COLOR_RESET}\n"
    
    check_root
    
    echo -e "${COLOR_YELLOW}Synchronizing package databases...${COLOR_RESET}"
    sudo pacman -Syy
    
    echo -e "\n${COLOR_YELLOW}Checking for broken dependencies...${COLOR_RESET}"
    sudo pacman -Dk
    
    echo -e "\n${COLOR_YELLOW}Reinstalling potentially broken packages...${COLOR_RESET}"
    sudo pacman -S $(pacman -Qkq)
    
    echo -e "\n${COLOR_YELLOW}Cleaning package cache...${COLOR_RESET}"
    sudo pacman -Sc --noconfirm
    
    echo -e "\n${COLOR_GREEN}Package repair attempt completed!${COLOR_RESET}"
}

check_system_services() {
    print_header
    echo -e "${COLOR_CYAN}System Services Check${COLOR_RESET}\n"
    
    check_root
    
    echo -e "${COLOR_YELLOW}Failed system services:${COLOR_RESET}\n"
    systemctl --failed
    
    echo -e "\n${COLOR_YELLOW}High resource usage services:${COLOR_RESET}\n"
    systemd-cgtop -n 1 | head -n 10
    
    echo -e "\n${COLOR_YELLOW}Recently started services:${COLOR_RESET}\n"
    systemctl list-units --type=service --state=running --no-pager | tail -n 10
} 