## Powershell script for getting summarized information about folders and subfolders

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

# Set the target directory
$directoryPath = "C:\Users\chanh\Downloads\originalPD"

# Get all top-level directories
$directoryInfo = Get-ChildItem -Path $directoryPath -Directory

# Initialize an array to store folder summary
$folderSummary = @()

foreach ($dir in $directoryInfo) {
    # Get subdirectories within each top-level directory
    $subdirectories = Get-ChildItem -Path $dir.FullName -Directory

    # Initialize counters for preop, postop, and timing-specified postop folders
    $preopCount = 0
    $postopCount = 0
    $timingCounts = @{
        "3M" = 0
        "6M" = 0
        "9M" = 0
        "1Y" = 0
        "2Y" = 0
        "3Y" = 0
        "4Y" = 0
        "5Y" = 0
    }

    foreach ($subdir in $subdirectories) {
        # Check if the subdirectory name matches the preop pattern
        if ($subdir.Name -match "^\d{8}_PreOp_Mx(Off|On)$") {
            $preopCount++
        }
        # Check if the subdirectory name matches the postop pattern
        elseif ($subdir.Name -match "^\d{8}_(\d+[Y|M])_DBS(On|Off)_Mx(Off|On)$") {
            $postopCount++
            $match = [regex]::Match($subdir.Name, "\d+[Y|M]").Value
            if ($timingCounts.ContainsKey($match)) {
                $timingCounts[$match]++
            }
        }
    }

    # Calculate total data count
    $totalCount = $preopCount + $postopCount

    # Add folder information to the summary array
    $folderSummary += [PSCustomObject]@{
        "Patient ID" = $dir.Name
        "Total"      = $totalCount
        "PreOp"      = $preopCount
        "PostOp"     = $postopCount
        "3M"         = $timingCounts["3M"]
        "6M"         = $timingCounts["6M"]
        "9M"         = $timingCounts["9M"]
        "1Y"         = $timingCounts["1Y"]
        "2Y"         = $timingCounts["2Y"]
        "3Y"         = $timingCounts["3Y"]
        "4Y"         = $timingCounts["4Y"]
        "5Y"         = $timingCounts["5Y"]
    }
}

# Convert to table format and display
$folderSummary | Format-Table *