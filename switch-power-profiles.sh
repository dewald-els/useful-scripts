#!/bin/bash

# Performance Profile Switcher for Linux Mint 22.3
# Switches between power profiles and adjusts display refresh rate accordingly

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo "Usage: $0 [power-saver|balanced|performance]"
    echo ""
    echo "Profiles:"
    echo "  power-saver   - Power saving mode (60Hz display)"
    echo "  balanced      - Balanced performance (60Hz display)"
    echo "  performance   - Maximum performance (90Hz display)"
    echo ""
    echo "Alias: 'battery-save' can be used instead of 'power-saver'"
    exit 1
}

# Function to check if running as root (not needed, but check anyway)
check_deps() {
    # Check for powerprofilesctl
    if ! command -v powerprofilesctl &> /dev/null; then
        echo -e "${RED}Error: powerprofilesctl not found. Installing power-profiles-daemon...${NC}"
        sudo apt-get update && sudo apt-get install -y power-profiles-daemon
    fi

    # Check for xrandr
    if ! command -v xrandr &> /dev/null; then
        echo -e "${RED}Error: xrandr not found. Installing x11-xserver-utils...${NC}"
        sudo apt-get install -y x11-xserver-utils
    fi
}

# Function to set refresh rate
set_refresh_rate() {
    local hz=$1

    # Get the current display and mode
    local display=$(xrandr | grep " connected primary" | awk '{print $1}')

    if [ -z "$display" ]; then
        display=$(xrandr | grep " connected" | head -1 | awk '{print $1}')
    fi

    if [ -z "$display" ]; then
        echo -e "${RED}Error: Could not detect display${NC}"
        return 1
    fi

    # Get current resolution
    local current_mode=$(xrandr | grep -A1 "^$display" | grep "\*" | awk '{print $1}')

    if [ -z "$current_mode" ]; then
        echo -e "${RED}Error: Could not detect current resolution${NC}"
        return 1
    fi

    # Try to set the refresh rate
    echo -e "${YELLOW}Setting display $display to ${current_mode}@${hz}Hz...${NC}"

    if xrandr --output "$display" --mode "$current_mode" --rate "$hz" 2>/dev/null; then
        echo -e "${GREEN}✓ Display refresh rate set to ${hz}Hz${NC}"
        return 0
    else
        echo -e "${YELLOW}Warning: Could not set ${hz}Hz. Available rates:${NC}"
        xrandr | grep -A20 "^$display" | grep "$current_mode"
        return 1
    fi
}

# Function to set power profile
set_power_profile() {
    local profile=$1

    echo -e "${YELLOW}Setting power profile to: $profile${NC}"

    if powerprofilesctl set "$profile" 2>/dev/null; then
        echo -e "${GREEN}✓ Power profile set to $profile${NC}"
        return 0
    else
        echo -e "${RED}Error: Failed to set power profile${NC}"
        echo "Available profiles:"
        powerprofilesctl list
        return 1
    fi
}

# Function to show interactive menu
show_menu() {
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" >&2
    echo -e "${GREEN}  Performance Profile Switcher${NC}" >&2
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" >&2
    echo "" >&2
    echo "Select a profile:" >&2
    echo "" >&2
    echo "  1) power-saver  - 60Hz refresh rate" >&2
    echo "  2) balanced     - 60Hz refresh rate" >&2
    echo "  3) performance  - 90Hz refresh rate" >&2
    echo "" >&2
    echo -n "Enter choice [1-3]: " >&2

    read -r choice

    case "$choice" in
        1)
            echo "power-saver"
            ;;
        2)
            echo "balanced"
            ;;
        3)
            echo "performance"
            ;;
        *)
            echo -e "\n${RED}Invalid choice${NC}" >&2
            exit 1
            ;;
    esac
}

# Main script
main() {
    local profile

    # Check if argument provided
    if [ $# -eq 0 ]; then
        # Show interactive menu
        profile=$(show_menu)
    elif [ $# -eq 1 ]; then
        profile=$1
    else
        usage
    fi

    # Check dependencies
    check_deps

    local refresh_rate=60

    # Validate and set profile
    case "$profile" in
        battery-save|power-saver)
            profile="power-saver"
            refresh_rate=60
            ;;
        balanced)
            profile="balanced"
            refresh_rate=60
            ;;
        performance)
            profile="performance"
            refresh_rate=90
            ;;
        *)
            echo -e "${RED}Error: Invalid profile '$profile'${NC}"
            usage
            ;;
    esac

    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  Performance Profile Switcher${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Set power profile
    if ! set_power_profile "$profile"; then
        exit 1
    fi

    echo ""

    # Set refresh rate
    if ! set_refresh_rate "$refresh_rate"; then
        echo -e "${YELLOW}Note: Power profile was changed, but refresh rate adjustment failed${NC}"
        exit 1
    fi

    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ Profile switch complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Run main function
main "$@"
