#!/bin/bash

# Theme management functions

manage_themes() {
    while true; do
        print_header
        echo -e "${COLOR_CYAN}ZeroLinux Theme Manager${COLOR_RESET}\n"
        echo -e "1. ${COLOR_GREEN}Apply Dark Theme${COLOR_RESET}"
        echo -e "2. ${COLOR_GREEN}Apply Light Theme${COLOR_RESET}"
        echo -e "3. ${COLOR_GREEN}Install Custom Theme${COLOR_RESET}"
        echo -e "4. ${COLOR_GREEN}Set ZeroLinux Default Theme${COLOR_RESET}"
        echo -e "5. ${COLOR_GREEN}Configure Desktop Layout${COLOR_RESET}"
        echo -e "6. ${COLOR_GREEN}Back to main menu${COLOR_RESET}"
        echo ""
        echo -e "Enter your choice [1-6]: "
        read -r theme_option
        
        case $theme_option in
            1) apply_dark_theme ;;
            2) apply_light_theme ;;
            3) install_custom_theme ;;
            4) apply_zerolinux_theme ;;
            5) configure_desktop_layout ;;
            6) return 0 ;;
            *) echo -e "${COLOR_RED}Invalid option${COLOR_RESET}" ;;
        esac
        
        echo -e "\nPress Enter to continue..."
        read -r
    done
}

apply_dark_theme() {
    echo -e "\n${COLOR_YELLOW}Applying dark theme...${COLOR_RESET}"
    lookandfeeltool -a org.kde.breezedark.desktop &
    spinner $! "Applying dark theme"
    
    # Set Kvantum theme
    mkdir -p ~/.config/Kvantum/
    echo "theme=KvGnomeDark" > ~/.config/Kvantum/kvantum.kvconfig
    
    # Set icon theme
    kwriteconfig5 --file ~/.config/kdeglobals --group Icons --key Theme "Papirus-Dark"
    
    echo -e "\n${COLOR_GREEN}Dark theme applied successfully!${COLOR_RESET}"
}

apply_light_theme() {
    echo -e "\n${COLOR_YELLOW}Applying light theme...${COLOR_RESET}"
    lookandfeeltool -a org.kde.breeze.desktop &
    spinner $! "Applying light theme"
    
    # Set Kvantum theme
    mkdir -p ~/.config/Kvantum/
    echo "theme=KvGnome" > ~/.config/Kvantum/kvantum.kvconfig
    
    # Set icon theme
    kwriteconfig5 --file ~/.config/kdeglobals --group Icons --key Theme "Papirus"
    
    echo -e "\n${COLOR_GREEN}Light theme applied successfully!${COLOR_RESET}"
}

install_custom_theme() {
    print_header
    echo -e "${COLOR_CYAN}Install Custom Theme${COLOR_RESET}\n"
    
    echo -e "Please select a theme category:"
    echo -e "1. ${COLOR_GREEN}Global Themes${COLOR_RESET}"
    echo -e "2. ${COLOR_GREEN}Plasma Themes${COLOR_RESET}"
    echo -e "3. ${COLOR_GREEN}Icon Themes${COLOR_RESET}"
    echo -e "4. ${COLOR_GREEN}Cursor Themes${COLOR_RESET}"
    echo -e "5. ${COLOR_GREEN}Back${COLOR_RESET}"
    echo ""
    echo -e "Enter your choice [1-5]: "
    read -r theme_category
    
    case $theme_category in
        1) plasma-discover --category "Global Themes" ;;
        2) plasma-discover --category "Plasma Themes" ;;
        3) plasma-discover --category "Icon Themes" ;;
        4) plasma-discover --category "Cursor Themes" ;;
        5) return 0 ;;
        *) echo -e "${COLOR_RED}Invalid option${COLOR_RESET}" ;;
    esac
}

apply_zerolinux_theme() {
    echo -e "\n${COLOR_YELLOW}Creating and applying ZeroLinux theme...${COLOR_RESET}"
    
    # Install required themes
    echo -e "\n${COLOR_YELLOW}Installing required theme packages...${COLOR_RESET}"
    sudo pacman -S --noconfirm kvantum-theme-materia materia-kde papirus-icon-theme &
    spinner $! "Installing required theme packages"
    
    # Create ZeroLinux specific theme directory
    sudo mkdir -p /usr/share/zerolinux/themes/
    
    # Create ZeroLinux color scheme
    mkdir -p ~/.local/share/color-schemes/
    cat > ~/.local/share/color-schemes/ZeroLinux.colors << EOF
[ColorEffects:Disabled]
Color=56,56,56
ColorAmount=0
ColorEffect=0
ContrastAmount=0.65
ContrastEffect=1
IntensityAmount=0.1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=112,111,110
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=77,77,77
BackgroundNormal=40,42,54
DecorationFocus=0,204,153
DecorationHover=0,204,153
ForegroundActive=0,204,153
ForegroundInactive=189,195,199
ForegroundLink=0,204,153
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=0,204,153
ForegroundVisited=127,140,141

[Colors:Complementary]
BackgroundAlternate=59,64,69
BackgroundNormal=49,54,59
DecorationFocus=30,146,255
DecorationHover=61,174,230
ForegroundActive=246,116,0
ForegroundInactive=175,176,179
ForegroundLink=61,174,230
ForegroundNegative=237,21,21
ForegroundNeutral=201,206,59
ForegroundNormal=239,240,241
ForegroundPositive=17,209,22
ForegroundVisited=61,174,230

[Colors:Selection]
BackgroundAlternate=29,153,243
BackgroundNormal=0,204,153
DecorationFocus=0,204,153
DecorationHover=0,204,153
ForegroundActive=252,252,252
ForegroundInactive=239,240,241
ForegroundLink=253,188,75
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=0,204,153
ForegroundVisited=189,195,199

[Colors:Tooltip]
BackgroundAlternate=77,77,77
BackgroundNormal=40,42,54
DecorationFocus=0,204,153
DecorationHover=0,204,153
ForegroundActive=0,204,153
ForegroundInactive=189,195,199
ForegroundLink=0,204,153
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=0,204,153
ForegroundVisited=127,140,141

[Colors:View]
BackgroundAlternate=40,42,54
BackgroundNormal=35,38,48
DecorationFocus=0,204,153
DecorationHover=0,204,153
ForegroundActive=0,204,153
ForegroundInactive=189,195,199
ForegroundLink=0,204,153
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=0,204,153
ForegroundVisited=127,140,141

[Colors:Window]
BackgroundAlternate=77,77,77
BackgroundNormal=40,42,54
DecorationFocus=0,204,153
DecorationHover=0,204,153
ForegroundActive=0,204,153
ForegroundInactive=189,195,199
ForegroundLink=0,204,153
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=0,204,153
ForegroundVisited=127,140,141

[General]
ColorScheme=ZeroLinux
Name=ZeroLinux
shadeSortColumn=true

[KDE]
contrast=4

[WM]
activeBackground=40,42,54
activeBlend=255,255,255
activeForeground=239,240,241
inactiveBackground=40,42,54
inactiveBlend=75,71,67
inactiveForeground=127,140,141
EOF
    
    # Apply theme
    lookandfeeltool -a org.kde.breezedark.desktop &
    spinner $! "Applying base theme"
    
    # Set Kvantum theme
    mkdir -p ~/.config/Kvantum/
    echo "theme=MateriaDark" > ~/.config/Kvantum/kvantum.kvconfig
    
    # Set custom color scheme
    kwriteconfig5 --file ~/.config/kdeglobals --group General --key ColorScheme "ZeroLinux"
    
    # Set icon theme
    kwriteconfig5 --file ~/.config/kdeglobals --group Icons --key Theme "Papirus-Dark"
    
    # Restart Plasma to apply changes
    echo -e "\n${COLOR_YELLOW}Restarting Plasma to apply changes...${COLOR_RESET}"
    kquitapp5 plasmashell || killall plasmashell
    kstart5 plasmashell &
    
    echo -e "\n${COLOR_GREEN}ZeroLinux theme applied successfully!${COLOR_RESET}"
    echo -e "${COLOR_CYAN}You may need to log out and log back in for all changes to take effect.${COLOR_RESET}"
}

configure_desktop_layout() {
    print_header
    echo -e "${COLOR_CYAN}Configure Desktop Layout${COLOR_RESET}\n"
    
    echo -e "Please select a desktop layout:"
    echo -e "1. ${COLOR_GREEN}Modern (Latte Dock)${COLOR_RESET}"
    echo -e "2. ${COLOR_GREEN}Traditional (Panel)${COLOR_RESET}"
    echo -e "3. ${COLOR_GREEN}Unity-style${COLOR_RESET}"
    echo -e "4. ${COLOR_GREEN}Back${COLOR_RESET}"
    echo ""
    echo -e "Enter your choice [1-4]: "
    read -r layout_option
    
    case $layout_option in
        1) configure_modern_layout ;;
        2) configure_traditional_layout ;;
        3) configure_unity_layout ;;
        4) return 0 ;;
        *) echo -e "${COLOR_RED}Invalid option${COLOR_RESET}" ;;
    esac
}

configure_modern_layout() {
    echo -e "\n${COLOR_YELLOW}Configuring modern layout with Latte Dock...${COLOR_RESET}"
    
    # Install Latte Dock if not installed
    if ! command_exists latte-dock; then
        sudo pacman -S --noconfirm latte-dock &
        spinner $! "Installing Latte Dock"
    fi
    
    # Kill existing instances
    killall latte-dock 2>/dev/null
    
    # Create Latte Dock config
    mkdir -p ~/.config/latte
    
    # Create a custom layout file
    cat > ~/.config/latte/ZeroLinux.layout.latte << EOF
[ActionPlugins][1]
RightButton;NoModifier=org.kde.contextmenu

[Containments][1]
activityId=
byPassWM=false
dockWindowBehavior=true
enableKWinEdges=true
formfactor=2
immutability=1
isPreferredForShortcuts=false
lastScreen=0
location=4
name=Default Dock
onPrimary=true
plugin=org.kde.latte.containment
raiseOnActivityChange=false
raiseOnDesktopChange=false
timerHide=700
timerShow=200
viewType=0
visibility=2
wallpaperplugin=org.kde.image

[Containments][1][Applets][2]
immutability=1
plugin=org.kde.latte.plasmoid

[Containments][1][Applets][2][Configuration]
PreloadWeight=0

[Containments][1][Applets][2][Configuration][General]
isInLatteDock=true
launchers59=applications:org.kde.dolphin.desktop,applications:org.kde.konsole.desktop,applications:firefox.desktop,applications:org.kde.discover.desktop

[Containments][1][Applets][3]
immutability=1
plugin=org.kde.plasma.analogclock

[Containments][1][ConfigDialog]
DialogHeight=600
DialogWidth=586

[Containments][1][Configuration]
PreloadWeight=0

[Containments][1][General]
advanced=false
alignment=0
alignmentUpgraded=true
appletOrder=2;3
iconSize=56
panelSize=10
shadowOpacity=60
shadowSize=45
shadows=All
showGlow=false
zoomLevel=0

[LayoutSettings]
activities=
backgroundStyle=0
color=blue
customBackground=
customTextColor=
icon=
lastUsedActivity=
launchers=
preferredForShortcuts=
showInMenu=true
version=2
EOF
    
    # Start Latte Dock with the custom layout
    nohup latte-dock --layout ZeroLinux --replace > /dev/null 2>&1 &
    
    # Configure panel to be smaller and at the top
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group PlasmaViews --group Panel --key panelVisibility --type int 1
    
    echo -e "\n${COLOR_GREEN}Modern layout configured successfully!${COLOR_RESET}"
}

configure_traditional_layout() {
    echo -e "\n${COLOR_YELLOW}Configuring traditional panel layout...${COLOR_RESET}"
    
    # Kill Latte Dock if running
    killall latte-dock 2>/dev/null
    
    # Reset Plasma to default
    mv ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/.config/plasma-org.kde.plasma.desktop-appletsrc.backup 2>/dev/null
    
    # Restart Plasma to apply default layout
    kquitapp5 plasmashell || killall plasmashell
    kstart5 plasmashell &
    
    echo -e "\n${COLOR_GREEN}Traditional layout configured successfully!${COLOR_RESET}"
    echo -e "${COLOR_CYAN}Plasma has been restarted with default panel layout.${COLOR_RESET}"
}

configure_unity_layout() {
    echo -e "\n${COLOR_YELLOW}Configuring Unity-style layout...${COLOR_RESET}"
    
    # Install Latte Dock if not installed
    if ! command_exists latte-dock; then
        sudo pacman -S --noconfirm latte-dock &
        spinner $! "Installing Latte Dock"
    fi
    
    # Kill existing instances
    killall latte-dock 2>/dev/null
    
    # Create Latte Dock config
    mkdir -p ~/.config/latte
    
    # Create a Unity-style layout file
    cat > ~/.config/latte/ZeroLinuxUnity.layout.latte << EOF
[ActionPlugins][1]
RightButton;NoModifier=org.kde.contextmenu

[Containments][1]
activityId=
byPassWM=false
dockWindowBehavior=true
enableKWinEdges=true
formfactor=2
immutability=1
isPreferredForShortcuts=false
lastScreen=0
location=3
name=Unity Dock
onPrimary=true
plugin=org.kde.latte.containment
raiseOnActivityChange=false
raiseOnDesktopChange=false
timerHide=700
timerShow=200
viewType=0
visibility=0
wallpaperplugin=org.kde.image

[Containments][1][Applets][2]
immutability=1
plugin=org.kde.latte.plasmoid

[Containments][1][Applets][2][Configuration]
PreloadWeight=0

[Containments][1][Applets][2][Configuration][General]
isInLatteDock=true
launchers59=applications:org.kde.dolphin.desktop,applications:org.kde.konsole.desktop,applications:firefox.desktop,applications:org.kde.discover.desktop

[Containments][1][ConfigDialog]
DialogHeight=600
DialogWidth=586

[Containments][1][Configuration]
PreloadWeight=0

[Containments][1][General]
advanced=false
alignment=0
alignmentUpgraded=true
appletOrder=2
iconSize=48
panelSize=10
shadowOpacity=60
shadowSize=45
shadows=All
showGlow=false
zoomLevel=0

[LayoutSettings]
activities=
backgroundStyle=0
color=blue
customBackground=
customTextColor=
icon=
lastUsedActivity=
launchers=
preferredForShortcuts=
showInMenu=true
version=2
EOF
    
    # Start Latte Dock with the Unity-style layout
    nohup latte-dock --layout ZeroLinuxUnity --replace > /dev/null 2>&1 &
    
    # Keep the panel at the top for global menu
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group PlasmaViews --group Panel --key panelVisibility --type int 1
    
    echo -e "\n${COLOR_GREEN}Unity-style layout configured successfully!${COLOR_RESET}"
} 