#!/bin/bash
set -e

INPUT=""
KEEP_INTERMEDIATE="delete"  # Default to "delete"

while [[ $# -gt 0 ]]; do
    case $1 in
        -k|--keep)
            KEEP_INTERMEDIATE="keep"
            shift
            ;;
        -d|--delete)
            KEEP_INTERMEDIATE="delete"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 <input.mmd> [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -k, --keep     Keep the intermediate PDF file"
            echo "  -d, --delete   Delete the intermediate PDF file (default)"
            echo "  -h, --help     Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 diagram.mmd              # Delete intermediate PDF (default)"
            echo "  $0 diagram.mmd -d           # Explicitly delete intermediate PDF"
            echo "  $0 diagram.mmd -k           # Keep intermediate PDF"
            exit 0
            ;;
        -*)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
        *)
            if [ -z "$INPUT" ]; then
                INPUT="$1"
            else
                echo "Error: Multiple input files specified"
                exit 1
            fi
            shift
            ;;
    esac
done

if [ -z "$INPUT" ]; then
    echo "Error: No input file specified"
    echo "Usage: $0 <input.mmd> [OPTIONS]"
    echo "Use -h or --help for more information"
    exit 1
fi

BASENAME=$(basename "$INPUT" .mmd)

echo "Generating PDF from $INPUT..."
mmdc -i "$INPUT" -o "$BASENAME.pdf"

echo "Cropping PDF..."
pdfcrop "$BASENAME.pdf" "$BASENAME-cropped.pdf"

if [ "$KEEP_INTERMEDIATE" != "keep" ]; then
    echo "Deleting intermediate PDF file..."
    rm "$BASENAME.pdf"
fi

echo "Done: $BASENAME-cropped.pdf"
