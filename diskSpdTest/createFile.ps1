$file= $args[0]
$vmName = (Select-String -Path $file "computer name:").Line.split(":")[1].trim()
$date = (Select-String -Path $file "start time:").Line.split(" ")[2].trim()
$timeUTC = (Select-String -Path $file "start time:").Line.split(" ")[3].trim()
$type = $args[1]
$proc = (Select-String -Path $file "proc count:").Line.split(":")[1].trim()

if ($proc -eq 8) {
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (39..46) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\CPU.csv
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (48) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\CPU.csv

    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (53..60) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\TotalIO.csv
    (Get-Content -Path $file -TotalCount 150 | Select-Object -Index (62)) -replace ":","|" | ForEach-Object {$_ + " | | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\TotalIO.csv

    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (67..74) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\ReadIO.csv
    (Get-Content -Path $file -TotalCount 150 | Select-Object -Index (76)) -replace ":","|" | ForEach-Object {$_ + " | | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\ReadIO.csv

    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (81..88) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\WriteIO.csv
    (Get-Content -Path $file -TotalCount 150 | Select-Object -Index (90)) -replace ":","|" | ForEach-Object {$_ + " | | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\WriteIO.csv
    
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (97..111) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\ReadLatency.csv
} else {
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (39..50) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\CPU.csv
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (52) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\CPU.csv
    
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (57..64) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\TotalIO.csv
    (Get-Content -Path $file -TotalCount 150 | Select-Object -Index (66)) -replace ":","|" | ForEach-Object {$_ + " | | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\TotalIO.csv
    
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (71..78) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\ReadIO.csv
    (Get-Content -Path $file -TotalCount 150 | Select-Object -Index (80)) -replace ":","|" | ForEach-Object {$_ + " | | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\ReadIO.csv
    
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (85..92) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\WriteIO.csv
    (Get-Content -Path $file -TotalCount 150 | Select-Object -Index (94)) -replace ":","|" | ForEach-Object {$_ + " | | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\WriteIO.csv
    
    Get-Content -Path $file -TotalCount 150 | Select-Object -Index (101..115) | ForEach-Object {$_ + " | " + $vmName + " | " + $date + " | " + $timeUTC + " | " + $type } >> report\ReadLatency.csv
}
