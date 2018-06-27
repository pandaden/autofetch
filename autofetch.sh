#!/bin/bash

################################################################################
# Check for the existence of the data in the interwebs.
# If the data exists, cache it. Remove local file,
# download new data file. Log the download. If the file does not
# exist, send an alert that the file failed ot cache
################################################################################

# Variables
cache="/cache/directory"
spider="/tmplog/directory"
alertemail="email@example.com"


# Array of data files we want to check for
declare -a datums=(
"https://example.com/sample1.csv"
"https://example.com/sample2.csv"
"https://example.com/sample3.csv"
"https://example.com/sample4.csv"
)

# Accepts three arguements, the url, the cache directory, the alert email
function autofetch() {
  
  # Store stdout in text file
  wget -S --spider $1 &> "$spider/spider.txt"

  # If the link resolves 200 then proceed
  # && -f $(basename $1)
  if grep -q 'HTTP/1.1 200 OK' "$spider/spider.txt" 
  then
    # Remove an existing file with the same name
    rm "$2/$(basename $1)" 2>/dev/null
    # Log date of download and filename
    printf "\n\n$(date)\n$1\n" >> "$spider/autofetch_log.txt"
    # Get the new file
    cd $2 && curl -O $1 2>>"$spider/autofetch_log.txt"
  else
    printf "$(date)\n$1\nFailed to cache" | mail -s "Autofetch alert: $(date)" $3
  fi
}

# Loop through the datums array and execute
for url in "${datums[@]}" 
do
  autofetch "$url" "$cache" "$alertemail"
done
