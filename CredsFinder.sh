#!/bin/bash

# AUTHOR
# lkim94

# DESCRIPTION
# This is a simple Bash script for finding clear text credentials in various files.
# It simply iterates over the specified file path, checks the contents of the files, and-
# -outputs the content that includes anything that has to do with credentials such as usernames and passwords.

# TESTED ON:
# Various Linux systems

# USAGE
# chmod +x ./CredsFinder.sh
# ./CredsFinder.sh <start_path>

# EXAMPLE
# ./CredsFinder.sh / --- Starts search from the system root directory.
# ./CredsFinder.sh /www/var/html --- Starts search from the /www/var/html directory.

# MODIFICATION INSTRUCTION
# The 'extensions' variable can be edited to add more file types to search. File types are separated by '|'.
# The 'find' commands's '-not -path' option in the for-loop can be edited based on your path exlusion need and search speed.

start_dir=$1

bold=`echo -en "\e[1m"`
normal=`echo -en "\e[0m"`

extensions='\s|\d|txt|log|cnf|conf|config|db|xml|php'
pattern='"username"|'username'|uname:|uname=|user:|user=|user>|usr:|usr=|"password"|'password'|passwd:|passwd=|pass:|pass=|pass>|pwd:|pwd=|pw:|pw=|mysqli_connect'

echo -e "\n[+] Searching from: $start_dir"
echo -e "[+] Checking the following file types: ${extensions[@]}\n"

#Edit the 'find' commands's '-not -path' option based on your path exlusion need and search speed.
for file in $(find $start_dir -type f -not -path "/boot/*" -not -path "/var/cache/*" -not -path "/sys/*" -not -path "/proc/*" -not -path "/snap/*" -not -path "/var/lib/*" -not -path "/lib/*" -not -path "/usr/*" 2>/dev/null)
do
    filename="${file##*/}"
    file_ext="${filename##*.}"
    content=$(grep -E -w -i $pattern $file 2>/dev/null)
    if [[ $file_ext =~ $extensions && ! -z "$content" ]]; then
        echo -e "\n${bold}[+] $file${normal}\n$content\n"
    fi
done
