# Autofetch

A simple bash script for autofetching files into a "cache" directory.

We loop through an array of user defined data file download urls. We check that each url is valid (HTTP/1.1 200 OK) before removing the existing file to download the new cache file. We then log to `autofetch_log.txt` with the date, filename and curl stdout.

The script is intended to run as a cron job where the autofetch will occur on a set interval.

NOTE: This script does not validate the contents of the files because assumes the owner is vetting of the data file urls he/she is adding to the url array. And it is recommended that validation of downloaded files is made whenever handling the files.

## License

This script is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
