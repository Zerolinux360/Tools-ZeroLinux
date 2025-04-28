# ZeroLinux Management Tool

A comprehensive system management tool for ZeroLinux, providing an easy-to-use interface for system maintenance, package management, theme customization, and troubleshooting.

## Features

- **Package Management**
  - System updates
  - Package installation/removal
  - Cache cleaning
  - Security tools installation
  - Development tools installation
  - Networking tools installation

- **Theme Management**
  - Dark/Light theme switching
  - Custom theme installation
  - ZeroLinux default theme
  - Desktop layout configuration
    - Modern (Latte Dock)
    - Traditional (Panel)
    - Unity-style

- **System Information**
  - Hardware details
  - System status
  - Resource usage
  - Network information

- **Troubleshooting Tools**
  - System logs analysis
  - Disk health check
  - Package repair
  - Service status monitoring

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Zerolinux360/Tools-ZeroLinux.git
cd zerolinux-tool
```

2. Make the script executable:
```bash
chmod +x src/core/zerolinux.sh
```

3. Create a symbolic link for easy access:
```bash
sudo ln -s "$(pwd)/src/core/zerolinux.sh" /usr/local/bin/zero
```

## Usage

```bash
zero [command] [options]
```

### Available Commands

- `update` - Update system and all packages
- `install` - Install packages
- `remove` - Remove packages
- `clean` - Clean package cache
- `security` - Install security tools
- `dev` - Install development tools
- `network` - Install networking tools
- `theme` - Manage system themes
- `system` - Show system information
- `troubleshoot` - System troubleshooting tools
- `help` - Show help information

## Requirements

- ZeroLinux or any Arch Linux-based distribution
- Bash shell
- sudo privileges for system operations
- Internet connection for package management

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GPL-3.0 License - see the LICENSE file for details.

## Acknowledgments

- Arch Linux community
- KDE Plasma team
- All contributors and users 
