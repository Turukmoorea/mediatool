# Mediatool

Mediatool is a modular CLI tool for managing media files efficiently.

## Features
- **Extract**: Handles archives (zip, rar, 7z, tar, etc.).
- **Compress**: Compresses files into supported formats.
- **Rename**: Organizes and renames media files.
- **Codec**: Converts video and audio formats.

## Getting Started
Run the following command to see available options:
```bash
python3 mediatool.py --help
```

More details are available in the [documentation](documentation/MANUAL/manpage.md).

## Licensing Information for Dependencies

### Extract and Compress Modules
For the **Extract** and **Compress** modules, external tools like `rar`, `tar`, `7z`, and `uip` are utilized. Please note that these tools may have their own licensing requirements. Ensure compliance with their respective licenses when using them.

### Rename Module
The **Rename** module uses [FileBot](https://www.filebot.net/), which is proprietary software. A valid license is required to use FileBot. Refer to their official website for more details on licensing: https://www.filebot.net/.

### Codec Module
The **Codec** module relies on [FFmpeg](https://ffmpeg.org/community.html#CodeOfConduct), an open-source project licensed under the LGPL/GPL. FFmpeg’s code of conduct and licensing details can be found on their [community page](https://ffmpeg.org/community.html#CodeOfConduct).

