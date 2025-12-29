#!/usr/bin/env bash

# Stop execution on the first error
set -e

# Make project-local fonts available to Typst
export TYPST_FONT_PATHS="$(pwd)/fonts"

# Input directory for .typ files
SRC_DIR="./documents"

# Output directory for compiled PDFs
OUT_DIR="./pdf"

# Create output directory if missing
mkdir -p "$OUT_DIR"

# Remove existing PDFs
rm -f "$OUT_DIR"/*.pdf

# Find all .typ files (recursively)
find "$SRC_DIR" -name "*.typ" | while read -r typ; do

  # Extract filename without extension
  name="$(basename "$typ" .typ)"
  
  # Define output PDF path
  out="$OUT_DIR/$name.pdf"

  # Show progress
  echo "Compiling $typ"

  # Compile with explicit project root
  typst compile "$typ" "$out" --root "$(pwd)"

done
