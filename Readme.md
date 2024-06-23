


```markdown
# YouTube Playlist Downloader

## Description

The YouTube Playlist Downloader script is a robust and user-friendly tool designed to help users download audio files from YouTube playlists. Leveraging the power of `yt-dlp`, this script allows you to extract high-quality audio from YouTube videos and save them in various formats. Additionally, the script supports embedding album art, automatically retrying failed downloads, and checking for updates in the playlist.

### Key Features

- Easy to Use: Provides a simple interface for downloading audio files from YouTube playlists.
- Customizable Settings: Offers various options to customize download settings, including directory, audio quality, format, and thumbnail saving.
- Automatic Retries: Implements a retry mechanism to handle failed downloads, ensuring a smooth downloading experience.
- Playlist Updates: Checks for new or updated videos in the playlist and downloads them, keeping your collection up-to-date.
- Progress Bar: Displays a progress bar with numbers from 1 to 100%, providing a visual representation of the download progress.

### How It Works

1. Download Selection: The script allows users to choose between default settings (K4NN4N's Choice) or custom settings for their downloads.
2. Custom Options: Users can specify the download directory, choose audio quality and format, and decide whether to save thumbnails.
3. Retry Mechanism: If a download fails, the script will automatically retry up to 10 times before skipping the file.
4. Post-Download Options: After the download completes, users can choose to retry failed downloads, check for playlist updates, or exit the script.

### Installation and Usage

#### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/K4NN4N/YT-Playlist-Downloader-.git
   cd YT-Playlist-Downloader-
   ```

2. Make the script executable:
   ```bash
   chmod +x YouTube\ Playlist\ YouTube Playlist Downloader.sh
   ```

#### Usage

To download audio files from a YouTube playlist, follow these steps:

1. Run the script in a terminal:
   ```bash
   ./YouTube\ Playlist\ Downloader.sh
   ```

2. Choose an option from the menu:
   - Help: Displays detailed information about the script and its features.
   - Retry Failed Downloads: Attempts to download any files that failed in previous attempts.
   - K4NN4N's Choice: Starts downloads using predefined settings optimized for high-quality audio.
   - Custom Options: Customize download settings including directory, audio quality, format, and thumbnail saving.

3. Enter the YouTube playlist URL when prompted.

4. Monitor the progress as the script downloads the audio files.

5. After downloading, choose to retry failed downloads, check for updates in the playlist, or exit.

### Script File

The main script file `YouTube Playlist Downloader.sh` is included in the repository for executing the YouTube Playlist downloading.

### Contributing and Support

Contributions to the project are welcome! Feel free to fork the repository and submit a pull request with your improvements. For any issues or questions, refer to the contact information provided in the credits section.

---