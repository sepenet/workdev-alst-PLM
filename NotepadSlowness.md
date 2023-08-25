# Capture traces and event during notepad slowness issue

if you are able to reproduce the issue, then follow the below steps to capture traces and events.

1- Open the command prompt as an administrator and run the below command to download the ADKsetup tool.
```powershell
Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=2165884 -outFile d:\adksetup.exe
```
2- Open explorer and navigate to d: drive 
3- right click on adksetup.exe and select run as administrator, **provide administrator** credentials if prompted.
![Run-as-admin](image-3.png)
4- Spécify Location, make sure **install the windows assess...** is selected and click on next
![location](image-4.png)
5- Select the privacy yes or no and click next
6- Read and accept the license terms and click next
7- uncheck all except windows performance toolkit and click install
![WPT](image-5.png)
8- wait for the installation to complete and click close
9- 