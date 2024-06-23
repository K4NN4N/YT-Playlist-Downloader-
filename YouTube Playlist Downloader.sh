#!/bin/bash

# Get the directory where the script is located
script_dir=$(dirname "$(realpath "$0")")

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

# Function to display the progress bar
progress_bar() {
    local duration=$1
    local interval=1
    local steps=$((duration / interval))
    echo -ne "${CYAN}Progress: ["
    for ((i=0; i<=steps; i++)); do
        printf "%3s%%" $((i * 100 / steps))
        sleep $interval
        printf "\b\b\b"
    done
    echo -ne "]${NC}\n"
}

# Function to read user input with default value
read_with_default() {
    local prompt=$1
    local default=$2
    read -p "$prompt [$default]: " input
    echo "${input:-$default}"
}

# Function to display the help section
show_help() {
    clear
    echo -e "${GREEN}####################################${NC}"
    echo -e "${GREEN}#      YouTube Playlist Downloader #${NC}"
    echo -e "${GREEN}####################################${NC}"
    echo ""
    echo -e "${YELLOW}Welcome to the YouTube Playlist Downloader Script!${NC}"
    echo -e "This script helps you download audio files from YouTube playlists with ease and flexibility."
    echo -e "Using yt-dlp, a powerful tool for downloading videos and extracting audio, this script provides several customization options."
    echo ""
    echo -e "${MAGENTA}Key Features:${NC}"
    echo "1. K4NN4N's Choice: Start downloads using predefined settings optimized for high-quality audio."
    echo "2. Custom Options: Customize download settings including directory, audio quality, format, and thumbnail saving."
    echo "3. Retry Logic: Automatically retry failed downloads up to 10 times before skipping."
    echo "4. Retry Failed Downloads: Easily retry downloads for any files that failed in previous attempts."
    echo "5. Check for Updates: Check for updates in the playlist and download new or updated videos."
    echo ""
    echo -e "${MAGENTA}How to Use:${NC}"
    echo "1. Run the Script: Execute the script in a Unix-like terminal emulator (e.g., Git Bash, WSL)."
    echo "2. Select an Option: Choose from retrying failed downloads, K4NN4N's Choice, or custom options."
    echo "3. Customize Your Downloads: If chosen, specify settings like directory, audio quality, and format."
    echo "4. Monitor Progress: The script displays download progress and logs any errors or retries."
    echo "5. Post-Download Options: After downloading, choose to retry failed downloads, check for updates, or exit."
    echo ""
    echo -e "${MAGENTA}Requirements:${NC}"
    echo "- yt-dlp: Make sure yt-dlp is installed and accessible from your terminal."
    echo "- Bash: A Unix-like shell to execute the script (e.g., Git Bash, WSL)."
    echo ""
    echo -e "${MAGENTA}Made by K4NN4N${NC}"
    echo "Follow on social media:"
    echo "- GitHub: https://github.com/K4NN4N"
    echo "- Twitter: https://twitter.com/K4NN4N"
    echo "- LinkedIn: https://www.linkedin.com/in/K4NN4N/"
    echo ""
    echo -e "${GREEN}####################################${NC}"
}

# Function to set custom options
set_custom_options() {
    download_directory=$(read_with_default "Enter the download directory (default: $script_dir)" "$script_dir")

    # Prompt for audio quality with common options
    echo -e "${CYAN}Select audio quality:${NC}"
    echo -e "1. ${YELLOW}320K${NC} (default)"
    echo -e "2. ${YELLOW}256K${NC}"
    echo -e "3. ${YELLOW}192K${NC}"
    echo -e "4. ${YELLOW}128K${NC}"
    echo -e "5. ${YELLOW}96K${NC}"
    read -p "Enter the number corresponding to your choice (default: 1): " audio_quality_choice
    case $audio_quality_choice in
        2) audio_quality="256K" ;;
        3) audio_quality="192K" ;;
        4) audio_quality="128K" ;;
        5) audio_quality="96K" ;;
        *) audio_quality="320K" ;;  # Default to 320K
    esac

    # Prompt for audio format with common options
    echo -e "${CYAN}Select audio format:${NC}"
    echo -e "1. ${YELLOW}mp3${NC} (default)"
    echo -e "2. ${YELLOW}aac${NC}"
    echo -e "3. ${YELLOW}flac${NC}"
    echo -e "4. ${YELLOW}m4a${NC}"
    echo -e "5. ${YELLOW}opus${NC}"
    echo -e "6. ${YELLOW}vorbis${NC}"
    read -p "Enter the number corresponding to your choice (default: 1): " audio_format_choice
    case $audio_format_choice in
        2) audio_format="aac" ;;
        3) audio_format="flac" ;;
        4) audio_format="m4a" ;;
        5) audio_format="opus" ;;
        6) audio_format="vorbis" ;;
        *) audio_format="mp3" ;;  # Default to mp3
    esac

    save_thumbnail=$(read_with_default "Save thumbnails? (yes/no, default: yes)" "yes")

    # Translate yes/no to appropriate yt-dlp options
    if [ "$save_thumbnail" = "yes" ]; then
        thumbnail_option="--embed-thumbnail"
    else
        thumbnail_option=""
    fi

    reverse_order=$(read_with_default "Download in reverse order? (yes/no, default: no)" "no")

    # Translate yes/no to appropriate yt-dlp options
    if [ "$reverse_order" = "yes" ]; then
        reverse_option="--playlist-reverse"
    else
        reverse_option=""
    fi
}

# Default "K4NN4N's Choice" settings
set_default_options() {
    download_directory="$script_dir"
    audio_quality="320K"
    audio_format="mp3"
    thumbnail_option="--embed-thumbnail"
    reverse_option=""
}

# Retry logic for failed downloads
retry_failed_downloads() {
    local url=$1
    local retries=0
    local max_retries=10
    local success=0

    while [ $retries -lt $max_retries ]; do
        yt-dlp -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" "$url"
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
    local timeout=$1
    for ((i = timeout; i > 0; i--)); do
        echo -ne "${CYAN}Time remaining: $i\033[0K\r${NC}"
        sleep 1
    done
    echo ""
}

# Main script loop
while true; do
    # Prompt user for option
    clear
    echo -e "${GREEN}Select an option:${NC}"
    echo -e "0. ${CYAN}Go to Home (Show options)${NC}"
    echo -e "1. ${CYAN}Help${NC}"
    echo -e "2. ${CYAN}Retry failed downloads from previous attempt${NC}"
    echo -e "3. ${CYAN}K4NN4N's Choice (default)${NC}"
    echo -e "4. ${CYAN}Custom options${NC}"
    read -p "Enter the number corresponding to your choice: " initial_choice

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
            yt-dlp -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option $reverse_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" --download-archive "$archive_file" --force-overwrites --retries 3 --ignore-errors --continue
            ;;
        4)
            set_custom_options
            ;;
        3 | *)
            set_default_options ;;  # Default to "K4NN4N#!/bin/bash

# Get the directory where the script is located
script_dir=$(dirname "$(realpath "$0")")

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

# Function to display the progress bar
progress_bar() {
    local duration=$1
    local interval=1
    local steps=$((duration / interval))
    echo -ne "${CYAN}Progress: ["
    for ((i=0; i<=steps; i++)); do
        printf "%3s%%" $((i * 100 / steps))
        sleep $interval
        printf "\b\b\b"
    done
    echo -ne "]${NC}\n"
}

# Function to read user input with default value
read_with_default() {
    local prompt=$1
    local default=$2
    read -p "$prompt [$default]: " input
    echo "${input:-$default}"
}

# Function to display the help section
show_help() {
    clear
    echo -e "${GREEN}####################################${NC}"
    echo -e "${GREEN}#      YouTube Playlist Downloader #${NC}"
    echo -e "${GREEN}####################################${NC}"
    echo ""
    echo -e "${YELLOW}Welcome to the YouTube Playlist Downloader Script!${NC}"
    echo -e "This script helps you download audio files from YouTube playlists with ease and flexibility."
    echo -e "Using yt-dlp, a powerful tool for downloading videos and extracting audio, this script provides several customization options."
    echo ""
    echo -e "${MAGENTA}Key Features:${NC}"
    echo "1. K4NN4N's Choice: Start downloads using predefined settings optimized for high-quality audio."
    echo "2. Custom Options: Customize download settings including directory, audio quality, format, and thumbnail saving."
    echo "3. Retry Logic: Automatically retry failed downloads up to 10 times before skipping."
    echo "4. Retry Failed Downloads: Easily retry downloads for any files that failed in previous attempts."
    echo "5. Check for Updates: Check for updates in the playlist and download new or updated videos."
    echo ""
    echo -e "${MAGENTA}How to Use:${NC}"
    echo "1. Run the Script: Execute the script in a Unix-like terminal emulator (e.g., Git Bash, WSL)."
    echo "2. Select an Option: Choose from retrying failed downloads, K4NN4N's Choice, or custom options."
    echo "3. Customize Your Downloads: If chosen, specify settings like directory, audio quality, and format."
    echo "4. Monitor Progress: The script displays download progress and logs any errors or retries."
    echo "5. Post-Download Options: After downloading, choose to retry failed downloads, check for updates, or exit."
    echo ""
    echo -e "${MAGENTA}Requirements:${NC}"
    echo "- yt-dlp: Make sure yt-dlp is installed and accessible from your terminal."
    echo "- Bash: A Unix-like shell to execute the script (e.g., Git Bash, WSL)."
    echo ""
    echo -e "${MAGENTA}Made by K4NN4N${NC}"
    echo "Follow on social media:"
    echo "- GitHub: https://github.com/K4NN4N"
    echo "- Twitter: https://twitter.com/K4NN4N"
    echo "- LinkedIn: https://www.linkedin.com/in/K4NN4N/"
    echo ""
    echo -e "${GREEN}####################################${NC}"
}

# Function to set custom options
set_custom_options() {
    download_directory=$(read_with_default "Enter the download directory (default: $script_dir)" "$script_dir")

    # Prompt for audio quality with common options
    echo -e "${CYAN}Select audio quality:${NC}"
    echo -e "1. ${YELLOW}320K${NC} (default)"
    echo -e "2. ${YELLOW}256K${NC}"
    echo -e "3. ${YELLOW}192K${NC}"
    echo -e "4. ${YELLOW}128K${NC}"
    echo -e "5. ${YELLOW}96K${NC}"
    read -p "Enter the number corresponding to your choice (default: 1): " audio_quality_choice
    case $audio_quality_choice in
        2) audio_quality="256K" ;;
        3) audio_quality="192K" ;;
        4) audio_quality="128K" ;;
        5) audio_quality="96K" ;;
        *) audio_quality="320K" ;;  # Default to 320K
    esac

    # Prompt for audio format with common options
    echo -e "${CYAN}Select audio format:${NC}"
    echo -e "1. ${YELLOW}mp3${NC} (default)"
    echo -e "2. ${YELLOW}aac${NC}"
    echo -e "3. ${YELLOW}flac${NC}"
    echo -e "4. ${YELLOW}m4a${NC}"
    echo -e "5. ${YELLOW}opus${NC}"
    echo -e "6. ${YELLOW}vorbis${NC}"
    read -p "Enter the number corresponding to your choice (default: 1): " audio_format_choice
    case $audio_format_choice in
        2) audio_format="aac" ;;
        3) audio_format="flac" ;;
        4) audio_format="m4a" ;;
        5) audio_format="opus" ;;
        6) audio_format="vorbis" ;;
        *) audio_format="mp3" ;;  # Default to mp3
    esac

    save_thumbnail=$(read_with_default "Save thumbnails? (yes/no, default: yes)" "yes")

    # Translate yes/no to appropriate yt-dlp options
    if [ "$save_thumbnail" = "yes" ]; then
        thumbnail_option="--embed-thumbnail"
    else
        thumbnail_option=""
    fi

    reverse_order=$(read_with_default "Download in reverse order? (yes/no, default: no)" "no")

    # Translate yes/no to appropriate yt-dlp options
    if [ "$reverse_order" = "yes" ]; then
        reverse_option="--playlist-reverse"
    else
        reverse_option=""
    fi
}

# Default "K4NN4N's Choice" settings
set_default_options() {
    download_directory="$script_dir"
    audio_quality="320K"
    audio_format="mp3"
    thumbnail_option="--embed-thumbnail"
    reverse_option=""
}

# Retry logic for failed downloads
retry_failed_downloads() {
    local url=$1
    local retries=0
    local max_retries=10
    local success=0

    while [ $retries -lt $max_retries ]; do
        yt-dlp -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" "$url"
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
    local timeout=$1
    for ((i = timeout; i > 0; i--)); do
        echo -ne "${CYAN}Time remaining: $i\033[0K\r${NC}"
        sleep 1
    done
    echo ""
}

# Main script loop
while true; do
    # Prompt user for option
    clear
    echo -e "${GREEN}Select an option:${NC}"
    echo -e "0. ${CYAN}Go to Home (Show options)${NC}"
    echo -e "1. ${CYAN}Help${NC}"
    echo -e "2. ${CYAN}Retry failed downloads from previous attempt${NC}"
    echo -e "3. ${CYAN}K4NN4N's Choice (default)${NC}"
    echo -e "4. ${CYAN}Custom options${NC}"
    read -p "Enter the number corresponding to your choice: " initial_choice

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
            yt-dlp -f bestaudio --extract-audio --audio-format "$audio_format" --audio-quality "$audio_quality" $thumbnail_option $reverse_option --add-metadata --output "$download_directory/%(playlist_index)02d %(title)s.%(ext)s" --download-archive "$archive_file" --force-overwrites --retries 3 --ignore-errors --continue
            ;;
        4)
            set_custom_options
            ;;
        3 | *)
            set_default_options ;;  # Default to "K4NN4N
