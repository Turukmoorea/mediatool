#!/bin/bash

echo
echo "================================================================="
echo "== This script is EOL and no longer supported.                 =="
echo "== Work is ongoing for its successor at                        =="
echo "== https://github.com/Turukmoorea/mediatool                    =="
echo "================================================================="
echo

# Default values for source and destination directories
timestamp_format="%Y-%m-%d %H:%M:%S"
default_source="."
default_destination="./extracted"
already_extracted_dir="" # Directory for already processed files, to be set dynamically in the source directory
source_dir="$default_source"
destination_dir="$default_destination"
remove_files=false # Flag to determine if original files should be deleted
specific_file=""  # Holds the specific file to process if provided
verbose=false # Flag to enable verbose mode

# Function: Display help
# Outputs usage instructions and exits

function display_help {
    echo "Usage: $0 -s [source_directory] -d [destination_directory] -f [specific_file] -o [options]"
    echo
    echo "Description:"
    echo "This script extracts compressed files from the specified source directory to a specified destination directory."
    echo "If no source directory is provided, it defaults to the current directory."
    echo "If no destination directory is provided, it defaults to './extracted'."
    echo
    echo "Supported Formats and Tools:"
    echo "  - RAR: Requires 'unrar'"
    echo
    echo "Options:"
    echo "  -h, --help         Show this help message and exit"
    echo "  -s [source]        Specify the source directory (default: current directory)"
    echo "  -d [destination]   Specify the destination directory (default: './extracted')"
    echo "  -f [file]          Specify a specific file or multi-part archive to extract"
    echo "  -r, --remove       Remove the original compressed file(s) after extraction"
    echo "  --part-allow       Enable processing of all part files"
    echo "  -v                 Enable verbose mode"
    echo
    echo "================================================================="
    echo "== Dieses Skript ist EOL und wird nicht mehr unterstützt.      =="
    echo "== Es wird am Nachfolger gearbeitet. Mehr Informationen unter: =="
    echo "== https://github.com/Turukmoorea/mediatool                    =="
    echo "================================================================="
    echo
    echo "Beschreibung:"
    echo "Dieses Skript entpackt komprimierte Dateien aus dem angegebenen Quellverzeichnis in ein Zielverzeichnis."
    echo "Wird kein Quellverzeichnis angegeben, wird standardmäßig das aktuelle Verzeichnis verwendet."
    echo "Wird kein Zielverzeichnis angegeben, wird standardmäßig './extracted' verwendet."
    echo
    echo "Unterstützte Formate und Tools:"
    echo "  - RAR: Benötigt 'unrar'"
    echo
    echo "Optionen:"
    echo "  -h, --help         Zeige diese Hilfe an und beende das Skript"
    echo "  -s [Quelle]        Gebe das Quellverzeichnis an (Standard: aktuelles Verzeichnis)"
    echo "  -d [Ziel]          Gebe das Zielverzeichnis an (Standard: './extracted')"
    echo "  -f [Datei]         Gebe eine spezifische Datei oder ein mehrteiliges Archiv an, das entpackt werden soll"
    echo "  -r, --remove       Entferne die ursprüngliche(n) komprimierte(n) Datei(en) nach dem Entpacken"
    echo "  --part-allow       Aktiviere die Verarbeitung aller Datei-Teile"
    echo "  -v                 Aktiviere den ausführlichen Modus"
    echo
    exit 0
}


# Parse arguments
# Loop through the provided arguments and set variables or display help
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -h | --help)
            display_help
            ;;
        -s)
            source_dir="$2"
            shift 2
            ;;
        -d)
            destination_dir="$2"
            shift 2
            ;;
        -f)
            specific_file="$2"
            shift 2
            ;;
        -r|--remove)
            remove_files=true
            shift
            ;;
        --part-allow)
            part_allow=true  # Enable processing of all part files
            shift
            ;;
        -v)
            verbose=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            display_help
            ;;
    esac
done

# Set the already_extracted_dir dynamically in the source directory
already_extracted_dir="$source_dir/already_extracted_originals"
processed_archives=() # Array to track processed archives

# Function: Check and install required tools
# Verifies if a required tool is installed, and prompts for installation if missing
function check_and_install {
    tool="$1"
    if ! command -v "$tool" &> /dev/null; then
        echo "$tool is not installed. Would you like to install it? [y/N]"
        read -t 60 install_tool
        if [[ "$install_tool" == "y" || "$install_tool" == "Y" ]]; then
            sudo apt update && sudo apt install -y "$tool"
        else
            echo "$tool will be skipped."
            return 1
        fi
    fi
    return 0
}

# Function: Extract the file
# Handles the extraction of a single file based on its extension
function extract_file {
    file="$1"
    ext="$2"
    timestamp=$(date +"$timestamp_format")
    echo "[$timestamp] Extracting file $file in process ..."

    case "$ext" in
        "rar")
            if $verbose; then
                check_and_install "unrar" && unrar x -o+ "$file" "$destination_dir"
            else
                check_and_install "unrar" && unrar x -o+ "$file" "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "7z")
            if $verbose; then
                check_and_install "p7zip-full" && p7zip x "$file" -o"$destination_dir"
            else
                check_and_install "p7zip-full" && p7zip x "$file" -o"$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "zip")
            if $verbose; then
                check_and_install "unzip" && unzip -o "$file" -d "$destination_dir"
            else
                check_and_install "unzip" && unzip -o "$file" -d "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "tar.gz"|"tgz")
            if $verbose; then
                check_and_install "tar" && tar -xvzf "$file" -C "$destination_dir"
            else
                check_and_install "tar" && tar -xvzf "$file" -C "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "tar.bz2")
            if $verbose; then
                check_and_install "tar" && tar -xvjf "$file" -C "$destination_dir"
            else
                check_and_install "tar" && tar -xvjf "$file" -C "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "tar.xz")
            if $verbose; then
                check_and_install "tar" && tar -xvJf "$file" -C "$destination_dir"
            else
                check_and_install "tar" && tar -xvJf "$file" -C "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        *)
            echo "[$timestamp] Unsupported multi-part archive format: $ext"
            return
            ;;
    esac

    # Handle post-processing (delete or move original file)
    if $remove_files; then
        rm "$file"
    else
        if [ ! -d "$already_extracted_dir" ]; then
            mkdir -p "$already_extracted_dir"
        fi
        mv "$file" "$already_extracted_dir"
    fi
}

# Function: Handle multi-part archives (RAR, 7z, etc.)
# Extracts only the first part of a multi-part archive and processes all parts
function handle_multipart_archive {
    base_file="$1"
    ext="$2"
    timestamp=$(date +"$timestamp_format")

    echo "[$timestamp] Extracting multi-part archive $base_file in process ..."

    # Determine prefix and syntax for multi-part archives
    case "$ext" in
        "rar")
            first_part_suffix=".part1.rar"
            part_pattern=".part[0-9]+.rar"
            ;;
        "7z")
            first_part_suffix=".7z.001"
            part_pattern=".7z.[0-9]{3}"
            ;;
        "zip")
            first_part_suffix=".zip"
            part_pattern=".z[0-9]{2}"
            ;;
        "tar.gz"|"tgz")
            first_part_suffix=".tar.gz"
            part_pattern=".tar.gz.part[0-9]+"
            ;;
        "tar.bz2")
            first_part_suffix=".tar.bz2"
            part_pattern=".tar.bz2.part[0-9]+"
            ;;
        "tar.xz")
            first_part_suffix=".tar.xz"
            part_pattern=".tar.xz.part[0-9]+"
            ;;
        *)
            echo "[$timestamp] Multi-part handling not supported for file type: $ext"
            return
            ;;
    esac

    # Build prefix and find first part
    part_prefix=$(echo "$base_file" | sed -E "s/${part_pattern}$//") # Remove part suffix
    first_part="${part_prefix}${first_part_suffix}"

    if [[ ! -f "$first_part" ]]; then
        echo "[$timestamp] First part ($first_part) not found. Skipping archive."
        return
    fi

    # Extract the archive using the appropriate tool
    case "$ext" in
        "rar")
            if $verbose; then
                check_and_install "unrar" && unrar x -o+ "$first_part" "$destination_dir"
            else
                check_and_install "unrar" && unrar x -o+ "$first_part" "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "7z")
            if $verbose; then
                check_and_install "p7zip-full" && p7zip x "$first_part" -o"$destination_dir"
            else
                check_and_install "p7zip-full" && p7zip x "$first_part" -o"$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "zip")
            if $verbose; then
                check_and_install "unzip" && unzip -o "$first_part" -d "$destination_dir"
            else
                check_and_install "unzip" && unzip -o "$first_part" -d "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "tar.gz"|"tgz")
            if $verbose; then
                check_and_install "tar" && tar -xvzf "$first_part" -C "$destination_dir"
            else
                check_and_install "tar" && tar -xvzf "$first_part" -C "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "tar.bz2")
            if $verbose; then
                check_and_install "tar" && tar -xvjf "$first_part" -C "$destination_dir"
            else
                check_and_install "tar" && tar -xvjf "$first_part" -C "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        "tar.xz")
            if $verbose; then
                check_and_install "tar" && tar -xvJf "$first_part" -C "$destination_dir"
            else
                check_and_install "tar" && tar -xvJf "$first_part" -C "$destination_dir" > /dev/null 2>&1
            fi
            ;;
        *)
            echo "[$timestamp] Unsupported multi-part archive format: $ext"
            return
            ;;
    esac

    # Post-processing: Remove or move all parts of the archive
    parts_to_process=$(find "$(dirname "$base_file")" -type f -name "$(basename "${part_prefix}")*")

    # Ensure paths do not have double slashes
    already_extracted_dir=$(realpath "$already_extracted_dir") # Normalize path
    already_extracted_dir="${already_extracted_dir%/}" # Remove trailing slash

    if $remove_files; then
        echo "[$timestamp] Removing all parts of the archive: $parts_to_process"
        rm -f $parts_to_process
    else
        if [ ! -d "$already_extracted_dir" ]; then
            mkdir -p "$already_extracted_dir"
        fi
        echo "[$timestamp] Moving all parts to $already_extracted_dir"
        mv $parts_to_process "$already_extracted_dir"
    fi

    echo "[$timestamp] Extraction of multi-part archive $base_file completed."
}


# Ensure the destination directory exists
if [ ! -d "$destination_dir" ]; then
    mkdir -p "$destination_dir"
fi

# Verify source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory $source_dir does not exist. Exiting."
    exit 1
fi

# Process a specific file if provided
if [[ -n "$specific_file" ]]; then
    ext=$(echo "$specific_file" | grep -oE '\.[^./]+$' | sed 's/^\.//')
    timestamp=$(date +"$timestamp_format")
    if [[ "$specific_file" == *.part1.* || "$specific_file" == *.[a-z][0-9][0-9] ]]; then
        echo "[$timestamp] Extracting multi-part archive $specific_file in procress ..."
        handle_multipart_archive "$specific_file" "$ext"
    else
        echo "[$timestamp] Extracting file $specific_file in process ..."
        extract_file "$specific_file" "$ext"
    fi
    echo "Extraction completed for file: $specific_file"
    exit 0
fi

# Loop through files in the source directory and process them
if [ -z "$(ls -A "$source_dir")" ]; then
    echo "Source directory is empty. No files to process."
    exit 0
fi

for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
        # Dateiendung extrahieren
        extension=$(echo "$file" | grep -oE '\.[^./]+$' | sed 's/^\.//')

        # Vermeide doppelte Schrägstriche
        file=$(realpath --relative-to="$PWD" "$file")

        # Handle multi-part extensions
        if [[ "$file" == *.part1.* || "$file" == *.[a-z][0-9][0-9] ]]; then
            handle_multipart_archive "$file" "$extension"
        else
            extract_file "$file" "$extension"
        fi
    fi
done



# Completion message
echo "Extraction process completed for directory: $source_dir"
