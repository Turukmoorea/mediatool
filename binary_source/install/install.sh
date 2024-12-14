#!/bin/bash

# Logging function
echo_log() {
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') $1"
}

echo_error() {
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') $1" >&2
}

# Define exit codes
declare -A EXIT_CODES=(
    [EXIT_SUCCESS]=0
    [EXIT_INVALID_ARGUMENTS]=2
    [EXIT_INSTALL_ERROR]=101
)

# Check if a parameter was passed
if [ $# -eq 0 ]; then
    echo_error "No parameter provided. Please specify the tool to be installed."
    exit ${EXIT_CODES[EXIT_INVALID_ARGUMENTS]}
fi

# Extract tool from the parameter
tool="$1"

# Function to install a package
install_tool() {
    package=$1
    if command -v $package >/dev/null 2>&1; then
        echo_log "$package is already installed."
    else
        echo_log "$package is being installed..."
        if sudo apt-get update && sudo apt-get install -y $package; then
            echo_log "$package was successfully installed."
        else
            echo_error "Error installing $package."
            exit ${EXIT_CODES[EXIT_INSTALL_ERROR]}
        fi
    fi
}

# Main logic with case statement
case $tool in
    rar)
        install_tool "rar"
        ;;
    unrar)
        install_tool "unrar"
        ;;
    p7zip-full)
        install_tool "p7zip-full"
        ;;
    tar)
        install_tool "tar"
        ;;
    zip)
        install_tool "zip"
        ;;
    unzip)
        install_tool "unzip"
        ;;
    *)
        echo_error "Unknown tool: $tool. Supported tools are: rar, unrar, p7zip-full, tar, zip, unzip."
        exit ${EXIT_CODES[EXIT_INVALID_ARGUMENTS]}
        ;;
esac

# Success message
echo_log "$tool was successfully processed."
exit ${EXIT_CODES[EXIT_SUCCESS]}