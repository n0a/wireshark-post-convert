#!/bin/bash

# This script is designed to search from the exported wireshark POST objects and convert it to a format convenient for viewing.
# Work tested on Linux and BSD systems and exclude specefic platform tools (tail -r on BSD, tac on Linux etc)
# tags: wireshark, export objects, post, mime types, wireshark export images, wireshark post upload.
# by n0a 2020 | https://n0a.pw

# Output directory
dir=found_files 
pwd=$(pwd)

echo "[+] Wireshark Objects Converter"
echo "[*] Working dir: $pwd"
echo "[*] Output dir: $dir"

if [ -w $pwd ]; then	
	if [ ! -d $dir ]; then
	    mkdir $dir
	    # Find all strings with "Content-Type:" exclude our .sh script and cut first three symbols.
	    grep --exclude=*.sh -rl "Content-Type:" . | cut -c3- |
		while read -r file; do
			# In $foundname var we get filename from wireshark objects file.
			foundname="$(sed -n 2p $file | awk '{print $4}' | cut -c10- | sed -e 's/\"//g' | tr -d '\r')"
			echo "[+] Convert $file to $foundname"
			# Delete first and last lines from wireshark objects with xxd without damage
	        [ ! -f "$dir/$foundname" ] && xxd -p "$file" | tr -d '\n' | \
										  sed -e 's/0d0a0d0a/z/1' -e 's/^.*z//1' \
										      -e 's/0d0a2d2d2d2d2d2d5765624b6974466f726d426f756e64617279.*$//1' | \
										  xxd -p -r > "$dir/$foundname"
		done
	    echo "[!] Success. Convert $(ls $dir | wc -l | awk '{ print $1 }') from $(ls $pwd | wc -l | awk '{ print $1 }') files."
	    echo "[*] Listing $dir:"
	    ls -lh $dir
	else
	    echo "[!] Output directory exists. Please remove $dir directory first."
	    echo "[*] Listing $dir:"
	    ls -lh $dir
	fi
else
   echo "[!] No write permission in a $pwd directory."
fi
