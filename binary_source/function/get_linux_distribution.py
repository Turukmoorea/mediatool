#!/bin/bash

# Script to detect the current distribution

# Error codes
EXIT_SUCCESS=0
EXIT_GENERAL_ERROR=1
EXIT_UNSUPPORTED_OS=202

# Logging function
log() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message"
}

# Determine the distribution
detect_distribution() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$NAME"
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo "$DISTRIB_ID"
    elif [ -f /etc/debian_version ]; then
        echo "Debian"
    elif [ -f /etc/redhat-release ]; then
        cat /etc/redhat-release
    elif uname -s | grep -iq "darwin"; then
        echo "macOS"
    elif uname -s | grep -iq "freebsd"; then
        echo "FreeBSD"
    elif uname -s | grep -iq "netbsd"; then
        echo "NetBSD"
    elif uname -s | grep -iq "openbsd"; then
        echo "OpenBSD"
    else
        log "ERROR" "Unsupported distribution or platform."
        exit $EXIT_UNSUPPORTED_OS
    fi
}

# Main logic
log "INFO" "Starting the script to detect the distribution."

# Detect distribution
distribution=$(detect_distribution 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$distribution" ]; then
    log "ERROR" "Failed to detect the distribution."
    exit $EXIT_GENERAL_ERROR
fi
log "INFO" "Detected distribution: $distribution"

# Output result (e.g., for a Python script)
echo "$distribution"

log "INFO" "Script completed successfully."
exit $EXIT_SUCCESS
