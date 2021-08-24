# CredsFinder
A Simple script for finding clear text credentials in various files.

## DESCRIPTION
This is a simeple Bash script for finding clear text credentials in various files.
It simply iterates over the specified file path, checks the contents of the files, and outputs the content that includes anything that has to do with credentials such as usernames and passwords.

## TESTED ON:
Various Linux systems

## USAGE
1. `chmod +x ./CredsFinder.sh`
2. `./CredsFinder.sh <start_path>`

## EXAMPLE
`./CredsFinder.sh /` --- Starts search from the system root directory.
`./CredsFinder.sh /www/var/html` --- Starts search from the /www/var/html directory.
![CredsFinderPoC](https://user-images.githubusercontent.com/83319068/130558822-f8505f52-2275-49a7-a136-4553f2f175f1.png)

## MODIFICATION INSTRUCTION
The 'extensions' variable can be edited to add more file types to search. File types are separated by '|'.
The 'find' commands's '-not -path' option in the for-loop can be edited based on your path exlusion need and search speed.
