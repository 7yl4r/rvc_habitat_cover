#!/bin/bash

# Declare associative array to map regions to their corresponding years
declare -A REGION_YEARS

# Assign years to each region
REGION_YEARS["DRY+TORT"]="
1999
2000
2004
2006
2008
"
# TODO: finish DRY+TORT
REGION_YEARS["FGNMS"]="
2018
2022
2023
"
REGION_YEARS["FLA+KEYS"]="
1999
2000
2001
2002
"
# TODO: finish FLA+KEYS
# TODO: add other regions

# Base URL
BASE_URL="https://grunt.sefsc.noaa.gov/rvc_analysis20/samples"

# Loop over each region
for REGION in "${!REGION_YEARS[@]}"; do
    # Read the multiline string into an array of years
    IFS=$'\n' read -r -d '' -a YEARS <<< "${REGION_YEARS[$REGION]}"
    
    # Loop over each year for the current region
    for YEAR in "${YEARS[@]}"; do
        # Trim any leading/trailing whitespace
        YEAR=$(echo "$YEAR" | xargs)
        
        # Skip empty lines
        if [ -z "$YEAR" ]; then
            continue
        fi

        # Construct the URL
        URL="${BASE_URL}?utf8=%E2%9C%93&region=${REGION}&year=${YEAR}&format=csv&commit=Download"
        
        # Construct the output file name
        OUTPUT_FILE="data/01_raw/${REGION}_${YEAR}.csv"
        
        # Download the file
        echo "Downloading ${OUTPUT_FILE}..."
        curl -o "${OUTPUT_FILE}" "${URL}"
    done
done

echo "All downloads completed."
