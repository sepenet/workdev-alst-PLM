# PLM test process to start PLM and record start and stop times

## without disk speed test

### Install ADKsetup tool

- [ ] Open powershell as Administrator and run the below command to download the ADKsetup tool.
    ```powershell
    Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=2165884 -outFile d:\adksetup.exe
    d:\adksetup.exe
    ```
- [ ] in "Specify Location" window, make sure **install the windows assess...** is selected and click on "**next**"
![location](image-4.png)
- [ ] Select the privacy yes or no and click "**next**"
- [ ] Read and accept the license terms and click "**next**"
- [ ] uncheck all except windows performance toolkit and click "**install**"
![WPT](image-5.png)
- [ ] wait for the installation to complete and click "**close**"

### Install Az powershell module.

- [ ] Install the Az powershell module by running the following command in powershell windows as an administrator 
    ```powershell
    Install-Module -Name Az.accounts,Az.Resources -AllowClobber
    Install-Module -Name Az.Compute
    ```
> Accept the installation of the module and dependencies by typing  **A** or **Y** and press enter
> this will take few minutes to complete
- [ ] Run the following commands to import the modules, login to azure using the user assigned managed identity.
    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
    Import-module az.accounts
    Import-module az.resources
    Import-module az.compute
    Connect-AzAccount -identity
    ```
>[!IMPORTANT]
> Accept the execution policy change by typing  **A**

<!-- ### dowload azcopy

- [ ] run the following commands to download and expand azcopy
    ```powershell
    Invoke-WebRequest -Uri https://aka.ms/downloadazcopy-v10-windows -outfile d:\azcopy.zip
    Expand-Archive -path d:\azcopy.zip -destinationpath d:
    mv d:\azcopy_windows_*\azcopy.exe d:\azcopy.exe
    ``` -->

### dowload the script which start the trace recording.

- [ ] run the following commands to create  to download the xperfStartup.ps1 file 
    ```powershell
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/sepenet/workdev-alst-PLM/main/MonitoringTroubleshoot/xperfStartup.ps1 -outFile d:\xperfStartup.ps1
    ```
### Start collecting the trace
>[!NOTE]
> Next step is to start recording the trace. As soon as the powershell windows is updated with the below grenish ribbon you can start PLM application as usual.

![xperf](image-6.png)

- [ ] run the following commands to create folder to collect VM info and to start traces recording
    ```powershell
    mkdir d:\xperf
    $HOSTNAME=$env:computername
    $VMPROPERTIES=get-azvm -name $HOSTNAME
    $RG=$VMPROPERTIES.psobject.properties["resourcegroupname"].value
    $VMPROPERTIES=get-azvm -name $HOSTNAME -displayHint expand -resourcegroupname $RG
    $VMIDVALUE=$VMPROPERTIES.psobject.properties["VmId"].value
    $DATETIME=get-date -format "dd-MMM-HH-mm-ss"
    echo "HOSTNAME,RG,VMIDVALUE,XperfSTARTTIME" | out-file d:\xperf\$HOSTNAME-$DATETIME-vmInfo.txt
    echo "$HOSTNAME,$RG,$VMIDVALUE,$DATETIME" | out-file -append d:\xperf\$HOSTNAME-$DATETIME-vmInfo.txt
    d:\xperfStartup.ps1 -pathETL d:\xperf -Save:$True
    mv d:\xperf\*.etl d:\xperf\$HOSTNAME-$DATETIME.etl
    & 'C:\Program Files\7-Zip\7z.exe' a -T7z D:\$HOSTNAME-$DATETIME.7z D:\xperf\*
    notepad d:\xperf\$HOSTNAME-$DATETIME-vmInfo.txt
    ```
>[!IMPORTANT]
> traces collection recording will start and last **15min** and will be saved in d:\xperf folder.
> You can stop the trace by pressing **ctrl+c** in the powershell window. In __any case__ please wait for PLM test to complete before stopping the trace.

command prompt windows will open automatically after the trace recording is stopped to save it in the file, let it runs, it closes automatically

![savefile](image-7.png)

>[!WARNING]
> do not stop the VM without saving the file, if you do so, you will **loose the file** as store on temporay store D: 




### save the file to FTP support ticket

- [ ] open edge browser and go to [File Transfer - Case 2309060050003065](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsupport.microsoft.com%2Ffiles%3Fworkspace%3DeyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ3c2lkIjoiMDBhOTkxYjItNDU0OS00NTc3LWI2MTgtZWQzY2YyNzliNGRlIiwic3IiOiIyMzA5MDYwMDUwMDAzMDY1IiwiYXBwaWQiOiJlNmVlNDNlYi0wZmJjLTQ1NDYtYmM1Mi00YzE2MWZjZGY0YzQiLCJzdiI6InYxIiwicnMiOiJFeHRlcm5hbCIsInd0aWQiOiIzNzc0YTY2Ni00ZDBjLTQ0NjUtYjQzYS01ZDcyNzBiMmM0ZWQiLCJpc3MiOiJodHRwczovL2FwaS5kdG1uZWJ1bGEubWljcm9zb2Z0LmNvbSIsImF1ZCI6Imh0dHA6Ly9zbWMiLCJleHAiOjE3MDE3ODYyNzQsIm5iZiI6MTY5NDAxMDI3NH0.hrAXmqdGraAxi4-G1bbp7V41PIClh6mO2X7T1CmSZUlhjca4YXj5ThyFJ_2EQmKQuoU7z4s1D-wakrEwdyxyu9hTHIac_X_VUVYpdHU7obldRyMZGNVGESvPwtDSZu1Igq21VO1sXt2QETLRqUzhsi2yrNQ6N5R9KYJm9ykozj28kA8PyXsWi4Q-iMCi0rwXG1Afx5HuqwDCTDGgAObRhThWiaYQStf8Tyc82G3hhdVK7jHZ6k3f37aoraT5NTlO-8ZwZzAxzXKxiMQb3I5stsDSBBqO5yg4bLL4J_Q7no1dxpCG2msSttSNMWokcrOi63S53iqsPy7rFDsvehez-Q%26wid%3D00a991b2-4549-4577-b618-ed3cf279b4de&data=05%7C01%7CSebastien.Penet%40microsoft.com%7C068bfa94398c4d8f130a08dbaee51a64%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638296071264344197%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=6GSYJmW7VmFKTNAsmvzz7M9dkdDyJ%2BesAvFFYeelfKw%3D&reserved=0) to upload the files \<Hostname\>-\<date time\>.7z available in D:\

![addfiles](image.png)

## Placeholder for info how to report to support. 
>[!IMPORTANT]
> please report it to support and provide the following information:
> copy the content of the file d:\xperf\$HOSTNAME-$DATETIME-vmInfo.txt opened in notepad and paste it in the support ticket.

<!-- ```powershell
mv d:\vmInfo.txt d:\xperf
$DATETIME=get-date -format "dd-MMM-HH-mm-ss"
mv d:\xperf\ d:\$HOSTNAME-$DATETIME
d:\azcopy.exe copy d:\$HOSTNAME-$DATETIME 'https://sebuploadfiles.blob.core.windows.net/xperf?sp=acw&st=2023-09-06T16:35:27Z&se=2023-09-07T00:35:27Z&spr=https&sv=2022-11-02&sr=c&sig=YaW6N40zb8JoY0TSfs%2FPr1jUasFI53ZW20FuRDQSkPA%3D' --recursive
``` -->


<!-- ## including diskspd test.
>[!IMPORTANT]
> this is not up to date -- DO NOT USE-- Only kept for reference

```powershell
d: 
mkdir speedTest
Invoke-WebRequest -Uri https://github.com/microsoft/diskspd/releases/download/v2.1/DiskSpd.ZIP -outFile d:\speedTest\DiskSpd.ZIP
Expand-Archive -path d:\speedTest\DiskSpd.ZIP -DestinationPath d:\speedTest\DiskSpd
echo "hostname,start time diskspd test,start time PLM app,stop time APP PLM" > d:\plmStart.txt
hostname >> d:\plmStart.txt
get-date -format "HH:mm:ss" >> d:\plmStart.txt
D:\speedTest\DiskSpd\amd64\diskspd.exe -d300 -W15 -C15 -L -r -w40 -t8 -b64K -Su -c10G C:\CATIA_V6_21X_FD14\perfdisk.io > D:\speedTest\plmVDIb64_01
pause
get-date -format "HH:mm:ss" >> d:\plmStart.txt
&'C:\Program Files\PLM4AUpdater\PLM4AUpdater.exe' "C:\Users\201039351\AppData\Local\PLM4ALauncher\INT\PLM4ALauncher_474ADE038B803AF8BDE177E432CB69D8.plm4a"
pause
get-date -format "HH:mm:ss" >> d:\plmStart.txt
D:\speedTest\DiskSpd\amd64\diskspd.exe -d300 -W15 -C15 -L -r -w40 -t8 -b64K -Su -c10G C:\CATIA_V6_21X_FD14\perfdisk.io > D:\speedTest\plmVDIb64_02
notepad d:\plmStart.txt
notepad D:\speedTest\plmVDIb64_02
notepad D:\speedTest\plmVDIb64_01
``` -->