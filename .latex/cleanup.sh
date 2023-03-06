#!/bin/bash

# All unneeded LaTeX and biber files
patterns=( "*.aux" "*.log" "*.bbl" "*.bcf" "*.blg" "*.run.xml" "*.tex.bbl" "*.tex.blg" )

# Loop through each pattern and remove matching files
for pattern in "${patterns[@]}"
do
	# Use the nullglob option to prevent error messages
	shopt -s nullglob

	# Remove all files matching the pattern
	rm -f $pattern

	# Check if any files were deleted
	if [ $? -eq 0 ]; then
		echo "Delete done for $pattern"
	fi
done

