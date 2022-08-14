#!/bin/bash
set -ueo pipefail

## Process command-line arguments
input_file=$1
output_file=$2

## Initial logging 
echo "Starting script $0"
date # Print date & time to log & time running duration
echo "Input file:   $input_file"
echo "Output file:  $output_file"

## Print the first and last two lines to a separate file
head -n 2 "$input_file" > "$output_file"
echo "---" >> "$output_file"
tail -n 2 "$input_file" >> "$output_file"

## Final logging
echo "Listing output file:"
ls -lh "$output_file"
echo "Done with script $0"
date
