#!/bin/bash

# Get the directory where the script is located
script_dir=$(dirname "$(realpath "$0")")

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

# Check if yt-dlp is installed
check_yt_dlp() {
    if ! command -v yt-dlp &> /dev/null; then
        echo -e "${RED}Error: yt-dlp is not installed or not in your PATH.${NC}"
        echo -e "${YELLOW}Please install yt-dlp using one of the following methods:${NC}"
        echo -e "${CYAN}1. Using pip (Python package manager):${NC}"
        echo "   pip install yt-dlp"
        echo -e "${CYAN}2. Using your system's package manager:${NC}"
        echo "   For Ubuntu/Debian: sudo apt-get install yt-dlp"
        echo "   For MacOS with Homebrew: brew install yt-dlp"
        echo -e "${CYAN}3. Download the binary from the official GitHub repository:${NC}"
        echo "   https://github.com/yt-dlp/yt-dlp#installation"
        echo -e "${YELLOW}After installation, make sure yt-dlp is in your system's PATH.${NC}"
        exit 1
    fi
}

# Call the check function at the beginning of the script
check_yt_dlp

# Function to display the progress bar
progress_bar() {
    # ... [unchanged] ...
}

# Function to read user input with default value
read_with_default() {
    # ... [unchanged] ...
}

# Function to display the help section
show_help() {
    # ... [unchanged] ...
}

# Function to set custom options
set_custom_options() {
    # ... [unchanged] ...
}

# Default "K4NN4N's Choice" settings
set_default_options() {
    # ... [unchanged] ...
}

# Retry logic for failed downloads
retry_failed_downloads() {
    local url=$1
    local retries=0
    local max_retries=10
    local success=0

    while [ $retries -lt $max_retries ]; do
        $(command -v yt-dlp) -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" "$url"
        if [ $? -eq 0 ]; then
            success=1
            break
        fi
        retries=$((retries + 1))
        echo -e "${YELLOW}Retrying download ($retries/$max_retries)...${NC}"
    done

    if [ $success -eq 0 ]; then
        echo -e "${RED}Failed to download after $max_retries retries. Skipping.${NC}"
    fi
}

# Timer function
start_timer() {
    # ... [unchanged] ...
}

# Main script loop
while true; do
    # ... [unchanged until the case statement] ...

    case $initial_choice in
        0)
            continue  # Restart the loop to show options again
            ;;
        1)
            show_help
            read -p "Press any key to return to menu..."
            ;;
        2)
            set_default_options
            log_file="$download_directory/download_log.txt"
            archive_file="$download_directory/archive.txt"
            $(command -v yt-dlp) -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option $reverse_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" --download-archive "$archive_file" --force-overwrites --retries 3 --ignore-errors --continue
            ;;
        4)
            set_custom_options
            ;;
        3 | *)
            set_default_options
            ;;
    esac

    # Prompt for playlist URL
    read -p "Enter the YouTube playlist URL: " playlist_url

    # Start the download process
    echo -e "${GREEN}Starting download...${NC}"
    $(command -v yt-dlp) -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option $reverse_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" "$playlist_url"

    # Post-download options
    echo -e "${GREEN}Download complete. Select an option:${NC}"
    echo -e "1. ${CYAN}Retry failed downloads${NC}"
    echo -e "2. ${CYAN}Check for updates${NC}"
    echo -e "3. ${CYAN}Exit${NC}"
    read -p "Enter your choice: " post_download_choice

    case $post_download_choice in
        1)
            retry_failed_downloads "$playlist_url"
            ;;
        2)
            $(command -v yt-dlp) -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option $reverse_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" --download-archive "$archive_file" --force-overwrites --retries 3 --ignore-errors --continue "$playlist_url"
            ;;
        3)
            echo -e "${GREEN}Thank you for using the YouTube Playlist Downloader. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Exiting.${NC}"
            exit 1
            ;;
    esac
done
