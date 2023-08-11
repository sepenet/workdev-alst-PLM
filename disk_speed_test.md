# test raw disk speed 

to perfrom the raw disk test, diskspd.exe is going to be used
to push the output to azure storage blob azcopy will be used

## Create the folder hosting the tools and results

```powershell
d:
mkdir speedTest
```

## Get azcopy

azcopy is available here : https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
Download the zip for 64bit windows and unzip it in the folder D:\speedTest.

```powershell
invoke-webrequest -uri https://aka.ms/downloadazcopy-v10-windows -outfile d:\speedTest\azcopy.zip
expand-archive -path d:\speedTest\azcopy.zip -destinationpath d:\speedTest
```

## copy to storage account

the doc is here https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/storage/common/storage-use-azcopy-blobs-upload.md
```powershell
.\azcopy.exe copy 'd:\perfmon' 'URL + Sas token' --recursive
```
to gt it go to the storage account, select the container and generate a SAS token for the container.

## Get diskspd.exe

tool is available here : https://github.com/Microsoft/diskspd/releases

Download the ZIP file and use the amd64 version. the following command line can be used to do it from a powershell administrator window on the VM
```powershell
Invoke-WebRequest -Uri https://github.com/microsoft/diskspd/releases/download/v2.1/DiskSpd.ZIP -outFile d:\speedTest\DiskSpd.ZIP
Expand-Archive -path d:\speedTest\DiskSpd.ZIP -DestinationPath d:\speedTest\DiskSpd
```


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
> current directory of the powershell windows should be the folder containing the file buildData, createBuildData.ps1, createFile.ps1 and dataSource folder

### update the powerbi report

- open the powerbi report
- hit the refresh button in the "Home" tab