# YouTube Playlist Downloader

A Bash script for easily downloading audio from YouTube playlists using yt-dlp, compatible with Unix-like environments and Termux on Android.

## Features

- **K4NN4N's Choice**: Start downloads using predefined settings optimized for high-quality audio.
- **Custom Options**: Customize download settings including directory, audio quality, format, and thumbnail saving.
- **Retry Logic**: Automatically retry failed downloads up to 10 times before skipping.
- **Retry Failed Downloads**: Easily retry downloads for any files that failed in previous attempts.
- **Check for Updates**: Check for updates in the playlist and download new or updated videos.
- **User-Friendly Interface**: Interactive menu for easy navigation and selection of options.

## Requirements

### For Unix-like Systems (Linux, macOS, Windows with WSL or Git Bash):
- Bash: Version 4.0 or higher
- yt-dlp: The script will check if it's installed and provide installation instructions if it's not
- curl or wget: For downloading the script (if not cloning the repository)
- Git: For cloning the repository (optional)

### For Termux on Android:
- Termux app installed from [F-Droid](https://f-droid.org/en/packages/com.termux/) (recommended) or Google Play Store
- Bash (pre-installed in Termux)
- yt-dlp (installation instructions provided below)
- Git (optional, for cloning the repository)

To check your Bash version, run:
```
bash --version
```

## Installation

### Option 1: Cloning the Repository

1. Open your terminal (or Termux on Android).
2. Navigate to the directory where you want to clone the repository.
3. Run the following command:
   ```
   git clone https://github.com/K4NN4N/YT-Playlist-Downloader-.git
   ```
4. Navigate into the cloned directory:
   ```
   cd YT-Playlist-Downloader-
   ```

### Option 2: Downloading the Script Directly

If you don't want to clone the entire repository, you can download the script directly:

1. Using curl:
   ```
   curl -O https://raw.githubusercontent.com/K4NN4N/YT-Playlist-Downloader-/main/youtube-playlist-downloader.sh
   ```
   Or using wget:
   ```
   wget https://raw.githubusercontent.com/K4NN4N/YT-Playlist-Downloader-/main/youtube-playlist-downloader.sh
   ```
 

2. Make the script executable:
   ```
   chmod +x youtube-playlist-downloader.sh
   ```

### Termux-Specific Setup

If you're using Termux on Android, follow these additional steps:

1. Update and upgrade Termux packages:
   ```
   pkg update && pkg upgrade
   ```

2. Install required packages:
   ```
   pkg install python ffmpeg
   ```

3. Install yt-dlp using pip:
   ```
   pip install yt-dlp
   ```

4. Grant storage permission to Termux (if not already granted):
   ```
   termux-setup-storage
   ```

## Usage

1. Run the script:
   ```
   ./youtube-playlist-downloader.sh
   ```
2. Follow the on-screen prompts to select your desired options:
   - Choose between K4NN4N's Choice (default settings) or custom options
   - Enter the YouTube playlist URL when prompted
   - Monitor the download progress
   - Choose post-download options (retry failed downloads, check for updates, or exit)

## Options

- **K4NN4N's Choice**: Uses default settings optimized for high-quality audio (320K mp3 with embedded thumbnails).
- **Custom Options**: Allows you to set:
  - Download directory
  - Audio quality (320K, 256K, 192K, 128K, 96K)
  - Audio format (mp3, aac, flac, m4a, opus, vorbis)
  - Thumbnail saving
  - Download order (normal or reverse)

## Troubleshooting

- If you encounter the error "yt-dlp: command not found", the script will provide instructions on how to install yt-dlp. Follow the provided instructions to install yt-dlp on your system.
- For Termux users, ensure you've granted storage permissions to Termux if you're having issues accessing the download directory.
- If you're using Windows, make sure you're running the script in a Unix-like environment such as Git Bash or WSL (Windows Subsystem for Linux).
- Ensure you have the necessary permissions to write to the download directory.

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check [issues page](https://github.com/yourusername/youtube-playlist-downloader/issues) if you want to contribute.

## Author

👤 **K4NN4N**

- GitHub: [@K4NN4N](https://github.com/K4NN4N)
- Twitter: [@K4NN4N](https://twitter.com/K4NN4N_)
- LinkedIn: [@K4NN4N](https://www.linkedin.com/in/K4NN4N/)

## Show your support

Give a ⭐️ if this project helped you!

## License

This project is [MIT](https://opensource.org/licenses/MIT) licensed.
