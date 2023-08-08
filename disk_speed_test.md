# test raw disk speed 

to perfrom the raw disk test, diskspd.exe is going to be used

## Get diskspd.exe

from an administrator powershell on the VM 
```powershell
d:
mkdir speedTest
cd speedTest
Invoke-WebRequest -Uri https://github.com/microsoft/diskspd/releases/download/v2.1/DiskSpd.ZIP -outFile DiskSpd.ZIP
Expand-Archive .\DiskSpd.ZIP

```
tool is available here : https://github.com/Microsoft/diskspd/releases

Download the ZIP file and use the amd64 version. 

## diskspd.exe command line  to execute

the following command line will be executed from the folder where diskspd.exe was saved.
It should be executed from a powershell windows, it is recommended to open the power with administrator permissions. 

```powershell
D:\speedTest\DiskSpd\amd64\diskspd.exe -d300 -W15 -C15 -L -r -w40 -t8 -b64K -Su -c10G C:\CATIA_V6_21X_FD14\perfdisk.io > D:\speedTest\plmVDIb64
```

## Save and share the results

### Save the results

- open the file D:\speedTest\plmVDIb64
- select all and copy.
- create a new file in the folder dataSource and paste the content of the clipboard in the new file.
- add a line to the file buildData.
- select all content of file buildData and copy.
- Paste it in a powershell window.
> current directory of the powershell windows should be the folder containint the file buildData, createBuildData.ps1, createFile.ps1 and dataSource folder

### update the powerbi report

- open the powerbi report
- hit the refresh button in the "Home" tab