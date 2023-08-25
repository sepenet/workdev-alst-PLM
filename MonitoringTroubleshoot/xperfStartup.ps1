<#
.DESCRIPTION
   Monitors process startup using xpeft.
.REQUIREMENTS
    - Windows 10-11
    - Windows Performance Toolkit, download location : https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/
        - Install only the Windows Performance Toolkit
    - Admin privileges
.USAGE
    xperfStartup.ps1 -pathETL <path to store ETL files>
.NOTES
    if you do not specify the pathETL parameter, the script will use the TEMP\etlTraces folder to store the ETL files
    You cancel the capture by pressing CTRL+C
#>
param(
    [Parameter(Mandatory=$True)]
    [string]$pathETL,

    [Parameter(Mandatory=$True)]
    [bool]$Save
)

[Console]::TreatControlCAsInput = $true
    
$xperfpath = "C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\wpr.exe"
$TraceCaptureDuration = 15 * 60


function CaptureData 
{
    param($duration=5,$xperfpath,$pathETL,$SaveTrace)
    # Get the date
    $date = Get-Date 
    # Use the custom format to specify datetime format
    $str = $date.ToString("dd-MM-yyyy-hh-mm-ss")

    $etlfile = -join($pathETL, "startup-", $str,".etl");

    $ctrl = $false

    if (Test-Path -Path $$etlfile) { Remove-Item -Path $$etlfile -Force }

    # Initiate Trace
    Write-Output "$(Get-Date) - Initiating trace, elaps: $($duration) seconds"
    
    $argstartup = "-start InternetExplorer -start DiskIO.light -start FileIO.light -start CPU.light -filemode"
    
    $ret = Start-Process -FilePath  $xperfpath -ArgumentList  $argstartup  -PassThru -Wait
    
    Write-Output "Start xPerf process: $xperfpath Exit code: $($ret.ExitCode.toString())"   

    if ($ret.ExitCode -eq -984087039) 
    {
        Write-Output "$(Get-Date) - Unable to record the trace because wpr.exe already started, cancel the capture"
        $argstartup = "-cancel"
        $ret = Start-Process -FilePath  $xperfpath -ArgumentList $argstartup  -PassThru -Wait
        return
    }



    if ($ret.ExitCode -eq 0) 
    {
        $ctrl = Start-Sleep $duration
    }   


    if ($ctrl -eq $false ) 
    { 
        if ($SaveTrace -eq $false)
        {
            Write-Output "$(Get-Date) - Trace capture cancelled by user, cancel the record."
            $argstartup = "-cancel"
            $ret = Start-Process -FilePath  $xperfpath -ArgumentList $argstartup  -PassThru -Wait
            return 
        }
    }

    $argstartup = "-stop $etlfile -skipPdbGen"
    Write-Output -Message "$(Get-Date) - stopping the trace..."

    $ret = Start-Process -FilePath  $xperfpath -ArgumentList $argstartup  -PassThru -Wait
    Write-Output "Stop xPerf file: $etlfile Exit code: $($ret.ExitCode.toString())"
    
}
 
function CheckDependencies {

    

    # verify xperf is accessible
    if (!(Test-Path -Path $xperfpath)) {
        write-host "Invalid path to xperf, expected path : $xperfpath exiting." 
        exit
    }

    # verify we are running with admin priv.
    $myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent();
    $myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID);

    # Get the security principal for the administrator role
    $adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator;

    # Check to see if we are currently running as an administrator
    if (!($myWindowsPrincipal.IsInRole($adminRole)))
    {
        write-host "This script needs to run as admin to invoke ETW data collection using Xperf. Exiting."
        exit
    }    
}

function Start-Sleep($seconds) {
    $doneDT = (Get-Date).AddSeconds($seconds)
    while($doneDT -gt (Get-Date)) {
        $secondsLeft = $doneDT.Subtract((Get-Date)).TotalSeconds
        $percent = ($seconds - $secondsLeft) / $seconds * 100
        Write-Progress -Activity "Waiting" -Status "Waiting..." -SecondsRemaining $secondsLeft -PercentComplete $percent
        [System.Threading.Thread]::Sleep(500)

        if ([Console]::KeyAvailable){

            $readkey = [Console]::ReadKey($true)
    
            if ($readkey.Modifiers -eq "Control" -and $readkey.Key -eq "C"){                                
                return $false
            }
        }
    }
    Write-Progress -Activity "Complete" -Status "Complete..." -SecondsRemaining 0 -Completed
    return $true
}

function createFolder($pathETL)
{
    if (!$pathETL)
    {
        $pathETL = $env:TEMP + "\etlTraces"        
    }
    If(!(test-path -PathType container $pathETL))
    {
          New-Item -ItemType Directory -Path $pathETL
    }
 
    if ( ! $pathETL.EndsWith("\")) 
    {
        $pathETL = $pathETL + '\'
    }
    return $pathETL
}

try
{
    $pathETL = createFolder $pathETL
    

    CheckDependencies 
    write-verbose -Message "$(get-date) - Monitoring application startup."
    CaptureData -duration $TraceCaptureDuration -xperfpath $xperfpath -pathETL $pathETL -SaveTrace $Save
}
catch
{
    write-host "error: $($_.Exception.Message)"
}