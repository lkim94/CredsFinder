# **CredsFinder.sh**

### DESCRIPTION
A simple Bash script for finding clear text credentials in various files.  
It simply iterates over the specified file path, checks the contents of the files, and outputs the content that includes anything that has to do with credentials such as usernames and passwords.  
This is to be used for educational and security testing purposes only and I'm not responsible for the misuse of this program.    

### USAGE  
1. `chmod +x ./CredsFinder.sh`  
2. `./CredsFinder.sh <start_path>`  

### EXAMPLE  
`./CredsFinder.sh /` --- Starts search from the system root directory.  
`./CredsFinder.sh /www/var/html` --- Starts search from the /www/var/html directory.  
![CredsFinderPoC](https://user-images.githubusercontent.com/83319068/130558822-f8505f52-2275-49a7-a136-4553f2f175f1.png)

### MODIFICATION INSTRUCTION
The 'extensions' variable can be edited to add more file types to search. File types are separated by '|'.  
The 'find' commands's '-not -path' option in the for-loop can be edited based on your path exlusion need and search speed.  
  
  
  
  
# **CredsFinder.ps1**

### DESCRIPTION 
A simple PowerShell script for finding clear text credentials in various files.  
It simply iterates over the specified file path, checks the contents of the files, and outputs the content that includes anything that has to do with credentials such as usernames and passwords.  
It only searches the files of the file types given by the default file type and by the user.  
Default file types are stored in the 'defaultFileTypes' variable.  
At the end, it also outputs a list of office files it discovered during the search.  
Some people like to store their usernames and passwords in office files such as word or excel documents :)  
This is to be used for educational and security testing purposes only and I'm not responsible for the misuse of this program.    

### USAGE  
1. PS >>> `Set-ExecutionPolicy -Scope CurrentUser Unrestricted` --- Enables running script.  
2. PS >>> `./CredsFinder.ps1 <start_path> <file_types(optional)>`  

### EXAMPLE  
PS >>> `./CredsFinder.ps1 C:\Users\Jason` --- Starts search from the 'C:\Users\Jason' directory with default file types.  
PS >>> `./CredsFinder.ps1 C:\Users\Jason .html, .py, .db` --- Does the same thing as above example, but with additional file types: html, py, and db.  

### NOTE
When specifying additional file types, multiple file types must be seperated by comma (,).  
File types must also begin with a dot (.).  
Ex) .html, .py, .ps1, .js, .db  
