#!/bin/bash

# Check if at least 1 argument is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_file [-o output_file]"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE=""

# Check for optional -o flag
if [ "$#" -eq 3 ] && [ "$2" == "-o" ]; then
    OUTPUT_FILE="$3"
elif [ "$#" -gt 1 ]; then
    echo "Usage: $0 input_file [-o output_file]"
    exit 1
fi

# Define taxonomic rank headers
TAXON_HEADERS="phylum\tclass\torder\tfamily\tgenus\tspecies"

# Read the first line, remove trailing tabs, and append taxon headers
FIRST_LINE=$(head -n 1 "$INPUT_FILE" | sed 's/\t*$//')
RESULT=$(echo -e "$FIRST_LINE\t$TAXON_HEADERS"; tail -n +2 "$INPUT_FILE")

# Output to file or stdout
if [ -n "$OUTPUT_FILE" ]; then
    echo -e "$RESULT" > "$OUTPUT_FILE"
else
    echo -e "$RESULT"
fi
