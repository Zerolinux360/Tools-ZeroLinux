#!/bin/bash

# ZeroLinux Management Tool
# Version: 1.0
# Author: ZeroLinux Team

# Source configuration
source "$(dirname "${BASH_SOURCE[0]}")/../utils/config.sh"

# Source modules
source "$(dirname "${BASH_SOURCE[0]}")/../modules/package_manager.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../modules/theme_manager.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../modules/system_info.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../modules/troubleshoot.sh"

# Main function
main() {
    case "$1" in
        update) update_system ;;
        install) shift; install_pkg "$@" ;;
        remove) shift; remove_pkg "$@" ;;
        clean) clean_system ;;
        security) install_security_tools ;;
        dev) install_dev_tools ;;
        network) install_network_tools ;;
        theme) manage_themes ;;
        system) show_system_info ;;
        troubleshoot) system_troubleshoot ;;
        help|"") show_help ;;
        *) echo -e "${COLOR_RED}Unknown command: $1${COLOR_RESET}"; show_help ;;
    esac
}

# Execute main function
main "$@" 