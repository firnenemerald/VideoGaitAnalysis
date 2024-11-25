## Powershell script for renaming gaitome algorithm result folders

# Copyright (C) 2024 Chanhee Jeong

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

## How to use
# 0. Make sure ExecutionPolicy is adjusted: Set-ExecutionPolicy RemoteSigned
# 1. Open PS terminal at the working directory
# 2. Type: powershell -noexit "& ""C:\Users\chanh\OneDrive\문서\__MyDocuments__\CodeBase\PSAutomation\RenameGaitFolders.ps1"""

# Specify the working directory
$workingDirectory = Get-Location

# Initialize a counter for the number of corrections
$correctionCount = 0

# Get all folder names within the specified directory
Get-ChildItem -Path $workingDirectory -Directory | ForEach-Object {
    $folderName = $_.Name

    # Split the folder name by the underscore delimiter
    $parts = $folderName -split "_"

    # Check if the folder name has the exact required number of elements
    if ($parts.Count -eq 7) {
        # Extract necessary parts
        $id = $parts[2] # Patient ID
        $condition = $parts[4].ToLower() # PreOp -> preop, post1Y -> post1y
        $dbStatus = $parts[5].ToLower() # MXOn -> mxon, DBSOnMxOff -> dbsonmxoff

        # Correct the condition based on specified rules
        if ($condition -eq "preop") {
            $condition = "PreOp"
        } elseif ($condition.StartsWith("post")) {
            $condition = $condition.Substring(4).ToUpper() # 1y -> 1Y, 6m -> 6M
        }

        # Correct the dbStatus based on specified rules
        switch ($dbStatus) {
            "mxon" { $dbStatus = "MxOn" }
            "mxoff" { $dbStatus = "MxOff" }
            "dbsonmxon" { $dbStatus = "DBSOnMxOn" }
            "dbsonmxoff" { $dbStatus = "DBSOnMxOff" }
            "dbsoffmxon" { $dbStatus = "DBSOffMxOn" }
            "dbsoffmxoff" { $dbStatus = "DBSOffMxOff" }
        }

        # Insert underscore between "DBSOn/Off" and "MxOn/Off" in dbStatus
        $dbStatus = $dbStatus -replace "(DBS\w+)(Mx\w+)", '$1_$2'

        # Construct the new folder name
        $newFolderName = "${id}_${condition}_${dbStatus}"

        # Create the full path for the old and new folders
        $oldFolderPath = Join-Path -Path $workingDirectory -ChildPath $folderName
        $newFolderPath = Join-Path -Path $workingDirectory -ChildPath $newFolderName

        # Rename the folder if the new name is different
        if ($newFolderName -ne $folderName) {
            Rename-Item -Path $oldFolderPath -NewName $newFolderPath

            # Print information about the correction
            Write-Host "Renamed: '$folderName' -> '$newFolderName'"
            
            # Increment the correction counter
            $correctionCount++
        }
    }
}

# Print the total number of corrections
Write-Host "Total corrections made: $correctionCount"