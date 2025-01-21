#!/bin/bash

# after done: execute
# chmod +x ai.sh
# ./ai.sh

for pdf_file in ./*.pdf; do
  # Extract the base name of the PDF (without the directory and extension)
  base_name=$(basename "$pdf_file" .pdf)
  output_folder="./book-$base_name"
  
  mkdir -p "$output_folder" # Create a folder using the PDF file name

  echo "Processing $pdf_file into $output_folder ..."
  
  # Convert PDF to images
  pdftocairo "$pdf_file" "$output_folder/page" -jpeg -cropbox # Adjust to -jpeg, -png, etc. as needed
    
  # Change to the output folder
  cd "$output_folder" || exit
  
  # Rename files
  for f in page-*.jpg; do
    mv "$f" "$(echo $f | sed -E 's/page-0+([0-9]+)\.jpg$/page-\1.jpg/')"
  done
  
  echo "Renamed files in $output_folder"

  # Go back to the original directory
  cd - > /dev/null
  
done