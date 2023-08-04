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

## diskspd.exe command line executed 

the following command line will be executed from the folder where diskspd.exe was saved.
It should be executed from a powershell windows, it is recommended to open the power with administrator permissions. 

```powershell
 .\diskspd.exe -d300 -W15 -C15 -L -r -w40 -t8 -b64K -Su -c10G C:\CATIA_V6_21X_FD14\perfdisk.io > d:\plmVDIb64
```


Command Line: D:\speedTest\DiskSpd\amd64\diskspd.exe -d120 -W15 -C15 -L -r -w40 -t8 -b64K -Su -c10G C:\CATIA_V6_21X_FD14\perfdisk.io

Input parameters:

	timespan:   1
	-------------
	duration: 120s
	warm up time: 15s
	cool down time: 15s
	measuring latency
	random seed: 0
	path: 'C:\CATIA_V6_21X_FD14\perfdisk.io'
		think time: 0ms
		burst size: 0
		software cache disabled
		using hardware write cache, writethrough off
		performing mix test (read/write ratio: 60/40)
		block size: 64KiB
		using random I/O (alignment: 64KiB)
		number of outstanding I/O operations per thread: 2
		threads per file: 8
		using I/O Completion Ports
		IO priority: normal

System information:

	computer name: vdsdc307839w925
	start time: 2023/08/04 12:31:07 UTC

Results for timespan 1:
*******************************************************************************

actual test time:	120.01s
thread count:		8
proc count:		12

CPU |  Usage |  User  |  Kernel |  Idle
-------------------------------------------
   0|   1.34%|   0.36%|    0.98%|  98.66%
   1|   0.52%|   0.07%|    0.46%|  99.48%
   2|   1.34%|   0.22%|    1.12%|  98.66%
   3|   0.72%|   0.20%|    0.52%|  99.28%
   4|   0.95%|   0.16%|    0.79%|  99.05%
   5|   0.42%|   0.04%|    0.38%|  99.58%
   6|   0.65%|   0.22%|    0.43%|  99.35%
   7|   5.47%|   1.18%|    4.28%|  94.53%
   8|  25.89%|  24.40%|    1.48%|  74.11%
   9|   0.29%|   0.21%|    0.08%|  99.71%
  10|   4.10%|   3.68%|    0.42%|  95.90%
  11|   2.33%|   2.17%|    0.16%|  97.67%
-------------------------------------------
avg.|   3.67%|   2.74%|    0.92%|  96.33%

Total IO
thread |       bytes     |     I/Os     |    MiB/s   |  I/O per s |  AvgLat  | LatStdDev |  file
-----------------------------------------------------------------------------------------------------
     0 |      1700134912 |        25942 |      13.51 |     216.16 |    9.251 |    17.590 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     1 |      1682571264 |        25674 |      13.37 |     213.92 |    9.347 |    17.671 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     2 |      1708720128 |        26073 |      13.58 |     217.25 |    9.204 |    17.556 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     3 |      1680080896 |        25636 |      13.35 |     213.61 |    9.361 |    17.697 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     4 |      1686437888 |        25733 |      13.40 |     214.41 |    9.326 |    17.667 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     5 |      1722875904 |        26289 |      13.69 |     219.05 |    9.129 |    17.501 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     6 |      1727135744 |        26354 |      13.72 |     219.59 |    9.106 |    17.477 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     7 |      1684602880 |        25705 |      13.39 |     214.18 |    9.336 |    17.678 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
-----------------------------------------------------------------------------------------------------
total:       13592559616 |       207406 |     108.01 |    1728.17 |    9.257 |    17.604

Read IO
thread |       bytes     |     I/Os     |    MiB/s   |  I/O per s |  AvgLat  | LatStdDev |  file
-----------------------------------------------------------------------------------------------------
     0 |      1018494976 |        15541 |       8.09 |     129.49 |   15.269 |    20.643 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     1 |      1009713152 |        15407 |       8.02 |     128.38 |   15.404 |    20.703 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     2 |      1032978432 |        15762 |       8.21 |     131.33 |   15.055 |    20.573 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     3 |      1016266752 |        15507 |       8.08 |     129.21 |   15.306 |    20.695 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     4 |      1008402432 |        15387 |       8.01 |     128.21 |   15.421 |    20.727 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     5 |      1022099456 |        15596 |       8.12 |     129.95 |   15.209 |    20.624 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     6 |      1040187392 |        15872 |       8.27 |     132.25 |   14.954 |    20.522 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     7 |      1009188864 |        15399 |       8.02 |     128.31 |   15.412 |    20.725 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
-----------------------------------------------------------------------------------------------------
total:        8157331456 |       124471 |      64.82 |    1037.13 |   15.252 |    20.652

Write IO
thread |       bytes     |     I/Os     |    MiB/s   |  I/O per s |  AvgLat  | LatStdDev |  file
-----------------------------------------------------------------------------------------------------
     0 |       681639936 |        10401 |       5.42 |      86.66 |    0.259 |     0.137 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     1 |       672858112 |        10267 |       5.35 |      85.55 |    0.259 |     0.149 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     2 |       675741696 |        10311 |       5.37 |      85.91 |    0.261 |     0.201 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     3 |       663814144 |        10129 |       5.27 |      84.40 |    0.260 |     0.131 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     4 |       678035456 |        10346 |       5.39 |      86.21 |    0.261 |     0.134 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     5 |       700776448 |        10693 |       5.57 |      89.10 |    0.259 |     0.157 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     6 |       686948352 |        10482 |       5.46 |      87.34 |    0.251 |     0.160 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
     7 |       675414016 |        10306 |       5.37 |      85.87 |    0.256 |     0.166 | C:\CATIA_V6_21X_FD14\perfdisk.io (10GiB)
-----------------------------------------------------------------------------------------------------
total:        5435228160 |        82935 |      43.19 |     691.04 |    0.258 |     0.156



total:
  %-ile |  Read (ms) | Write (ms) | Total (ms)
----------------------------------------------
    min |      0.041 |      0.080 |      0.041
   25th |      0.379 |      0.177 |      0.244
   50th |      3.589 |      0.220 |      0.382
   75th |     44.561 |      0.305 |      3.870
   90th |     46.524 |      0.410 |     45.642
   95th |     48.437 |      0.481 |     47.121
   99th |     49.633 |      0.656 |     49.337
3-nines |     53.694 |      1.396 |     52.331
4-nines |     66.206 |      4.803 |     63.928
5-nines |    107.708 |     15.066 |    103.490
6-nines |    107.957 |     15.066 |    107.957
7-nines |    107.957 |     15.066 |    107.957
8-nines |    107.957 |     15.066 |    107.957
9-nines |    107.957 |     15.066 |    107.957
    max |    107.957 |     15.066 |    107.957
