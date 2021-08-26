# DESCRIPTION
# This is a simple PowerShell script for finding clear text credentials in various files.
# It simply iterates over the specified file path, checks the contents of the files, and-
# -outputs the content that includes anything that has to do with credentials such as usernames and passwords.
# It only searches the files of the file types given by the default file type and by the user.
# Default file types are stored in the 'defaultFileTypes' variable.
# At the end, it also outputs a list of office files it discovered during the search.
# Some people like to store their usernames and passwords in office files such as word or excel documents :)

# AUTHOR
# lkim94

# USAGE
# 1. PS >>> Set-ExecutionPolicy -Scope CurrentUser Unrestricted
# 2. PS >>> ./CredsFinder.ps1 <start_path> <file_types(optional)>

# EXAMPLE
# PS >>> ./CredsFinder.ps1 C:\Users\Jason --- Starts search from the 'C:\Users\Jason' directory with default file types.
# PS >>> ./CredsFinder.ps1 C:\Users\Jason .html, .py, .db --- Does the same thing as above example, but with additional file types: html, py, and db.

# NOTE
# When specifying additional file types, multiple file types must be seperated by comma (,).
# File types must also begin with a dot (.).
# Ex) .html, .py, .ps1, .js, .db


[CmdletBinding()]
param (
    [Parameter (Mandatory=$true)] [string] $startDir = $null, 
    [Parameter (Mandatory=$false)] [array] $fileTypes = $null
)


$officeFileTypes = @('.doc', '.docx', '.xls', '.xlsx', '.xlam', '.xlsm', '.xlsb', '.pptx', '.pptm', '.ppt')
$defaultFileTypes = @('.txt', '.csv', '.log', '.cnf', '.conf', '.config', '.xml', '.asp', '.aspx', '.jsp', '.php')
$fileTypes += $defaultFileTypes

$credsPattern = "([/<`"';]{1}(username|uname|user|usr|password|passwd|pass|pwd|pw)[>`"':=]{1})"
$FuncPattern = "((sqlsrv|mysqli|pg|mssql)_connect)"

$officeFiles = @()


Write-Host `r`n"[+] Searching from: $startDir"
Write-Host "[+] Checking the following file types: $fileTypes `r`n"

$files = Get-ChildItem -Path $startDir -Recurse -Force -File -ErrorAction SilentlyContinue
ForEach ($file in $files)
{
    if ($file.Extension -in $fileTypes) 
    {
        $content = Get-Content $file.FullName -ErrorAction SilentlyContinue
        $line = $content | Select-String -Pattern $credsPattern, $funcPattern
        if ($line)
        {
            Write-Host -Fore Green "`r`n[+]" $file.FullName
            Write-Host $line`r`n
        }
    }
    elseif ($file.Extension -in $officeFileTypes) {
        $officeFiles += $file.FullName
    }
}

Write-Host -Fore Green "`r`n[+] Office files that might contain useful information: "
ForEach ($file in $officeFiles)
{
    Write-Host "`t[+] $file"
}
Write-Host `r`n