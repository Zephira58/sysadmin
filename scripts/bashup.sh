#!/bin/bash
# bashupload.sh
# Simple upload/download script for bashupload.com
# Usage:
#   bashupload.sh upload <file>
#   bashupload.sh download <url> [output_file]
#   bashupload.sh --help

set -e

COMMAND=$1
shift

show_help() {
    echo "bashupload - Upload or download files via bashupload.com"
    echo
    echo "Usage:"
    echo "  bashupload upload <file>           Upload a file and get a URL"
    echo "  bashupload download <url> [file]  Download a file from URL (optional output filename)"
    echo "  bashupload --help                  Show this help menu"
}

upload_file() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        echo "File not found: $file"
        exit 1
    fi
    echo "Uploading $file..."
    RESPONSE=$(curl -s -F "file=@$file" https://bashupload.com)
    echo "Upload complete! URL: $RESPONSE"
}

download_file() {
    local url="$1"
    local output="${2:-$(basename "$url")}"
    echo "Downloading $url to $output..."
    curl -L "$url" -o "$output"
    echo "Download complete."
}

case "$COMMAND" in
    upload)
        upload_file "$1"
        ;;
    download)
        download_file "$1" "$2"
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $COMMAND"
        show_help
        exit 1
        ;;
esac
