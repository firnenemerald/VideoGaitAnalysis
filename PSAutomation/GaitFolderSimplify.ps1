## Powershell script for renaming gaitome algorithm result folders

# SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr>
# SPDX-License-Identifier: GPL-3.0-or-later

## How to use
# 0. Make sure ExecutionPolicy is adjusted: Set-ExecutionPolicy RemoteSigned
# 1. Open PS terminal at the working directory
# 2. Type: powershell -noexit "& ""C:\Users\chanh\OneDrive\문서\__MyDocuments__\VideoGaitAnalysis\PSAutomation\GaitFolderSimplify.ps1"""

# Specify the working directory
$workingDirectory = Get-Location

# Initialize a counter for the number of corrections
$correctionCount = 0

# Get all folder names within the specified directory
Get-ChildItem -Path $workingDirectory -Directory | ForEach-Object {
    # Extract necessary parts
    $folderName = $_.Name
    $parts = $folderName -split "_"
    $date = $parts[0]
    $id = $parts[1]

    # Construct the new folder name
    $newFolderName = "${id}"

    # Create the full path for the old and new folders
    $oldFolderPath = Join-Path -Path $workingDirectory -ChildPath $folderName
    $newFolderPath = Join-Path -Path $workingDirectory -ChildPath $newFolderName

    # Rename the folder if the new name is different
    if ($newFolderName -ne $folderName) {
        Rename-Item -Path $oldFolderPath -NewName $newFolderPath
        Write-Host "Renamed: '$folderName' -> '$newFolderName'"
        $correctionCount++
    }
}