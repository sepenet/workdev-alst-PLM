write-host "Reseting the base file"
.\createBaseFile.ps1
write-host "Starting to create files for premium SSD with preloader"
Get-ChildItem .\dataSource\PremSSDPreloader | foreach { .\createFile.ps1 $_.fullname "Premium SSD with preloader" }
Write-Host "Starting to create files for ephemeral"
Get-ChildItem .\dataSource\ephemeral | foreach { .\createFile.ps1 $_.fullname "ephemeral" }
write-host "Starting to create files for Premium SSD no preloader"
Get-ChildItem .\dataSource\PremSSDNoPreloader | foreach { .\createFile.ps1 $_.fullname "Premium SSD no preloader" }