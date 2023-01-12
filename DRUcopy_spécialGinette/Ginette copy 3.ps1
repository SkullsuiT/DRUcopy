function Copy-WithProgress {
    [CmdletBinding()]
    param (
            [Parameter(Mandatory = $true)]
            [string] $Source
        , [Parameter(Mandatory = $true)]
            [string] $Destination
        , [int] $Gap = 200
        , [int] $ReportGap = 2000
    )
    # Define regular expression that will gather number of bytes copied
    $RegexBytes = '(?<=\s+)\d+(?=\s+)';

    #region Robocopy params
    # MIR = Mirror mode
    # NP  = Don't show progress percentage in log
    # NC  = Don't log file classes (existing, new file, etc.)
    # BYTES = Show file sizes in bytes
    # NJH = Do not display robocopy job header (JH)
    # NJS = Do not display robocopy job summary (JS)
    # TEE = Display log in stdout AND in target log file
    $XF                                      = '/Xf "*.mp4" "*.mp3" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
    $CommonRobocopyParams = "*.* /s /tee /Eta /timfix $XF /MIR /J /r:5 /w:2 /Xo /NDL /NJH /NJS";
    #endregion Robocopy params

    #region Robocopy Staging
    Write-Verbose -Message 'Analyzing robocopy job ...';
    $StagingLogPath = "RoboCopy_$env:COMPUTERNAME"+"_"+"$env:UserName.log";

    $StagingArgumentList = $Source, $Destination, $StagingLogPath, $CommonRobocopyParams;
    Write-Verbose -Message ('Staging arguments: {0}' -f $StagingArgumentList);
    Start-Process -Wait -FilePath robocopy.exe -ArgumentList $StagingArgumentList -NoNewWindow;
    # Get the total number of files that will be copied
    $StagingContent = Get-Content -Path $StagingLogPath;
    $TotalFileCount = $StagingContent.Count - 1;

    # Get the total number of bytes to be copied
    [RegEx]::Matches(($StagingContent -join "`n"), $RegexBytes) | % { $BytesTotal = 0; } { $BytesTotal += $_.Value; };
    Write-Verbose -Message ('Total bytes to be copied: {0}' -f $BytesTotal);
    #endregion Robocopy Staging

    #region Start Robocopy
    # Begin the robocopy process
    $RobocopyLogPath = '{0}\temp\{1} robocopy.log' -f $env:windir, (Get-Date -Format 'yyyy-MM-dd HH-mm-ss');
    $ArgumentList = '"{0}" "{1}" /LOG:"{2}" /ipg:{3} {4}' -f $Source, $Destination, $RobocopyLogPath, $Gap, $CommonRobocopyParams;
    Write-Verbose -Message ('Beginning the robocopy process with arguments: {0}' -f $ArgumentList);
    $Robocopy = Start-Process -FilePath robocopy.exe -ArgumentList $ArgumentList -Verbose -PassThru -NoNewWindow;
    Start-Sleep -Milliseconds 100;
    #endregion Start Robocopy

    #region Progress bar loop
    while (!$Robocopy.HasExited) {
        Start-Sleep -Milliseconds $ReportGap;
        $BytesCopied = 0;
        $LogContent = Get-Content -Path $RobocopyLogPath;
        $BytesCopied = [Regex]::Matches($LogContent, $RegexBytes) | ForEach-Object -Process { $BytesCopied += $_.Value; } -End { $BytesCopied; };
        $CopiedFileCount = $LogContent.Count - 1;
        $progressBar.Value = ($BytesCopied/$BytesTotal)*100
    $fileLabel.Text = "Files Copied: $CopiedFileCount"
    $byteLabel.Text = "Bytes Copied: $BytesCopied"
}
    #endregion Progress loop

    #region Function output
    [PSCustomObject]@{
        BytesCopied = $BytesCopied;
        FilesCopied = $CopiedFileCount;
    };
    #endregion Function output
}
Function FunctionMOT {
    Param(
        [Parameter(Mandatory=$true)][string]$string
        , [Parameter(Mandatory=$true)][char]$character
        , [Parameter(Mandatory=$false)][ValidateSet("Right","Left")][string]$range
        , [Parameter(Mandatory=$false)][int]$afternumber
        , [Parameter(Mandatory=$false)][int]$tonumber
    )
    Process
    {
        [string]$return = ""

        if ($range -eq "Right")
        {
            $return = $string.Split("$character")[($string.Length - $string.Replace("$character","").Length)]
        }
        elseif ($range -eq "Left")
        {
            $return = $string.Split("$character")[0]
        }
        elseif ($tonumber -ne 0)
        {
            for ($i = $afternumber; $i -le ($afternumber + $tonumber); $i++)
            {
                $return += $string.Split("$character")[$i]
            }
        }
        else
        {
            $return = $string.Split("$character")[$afternumber]
        }

        return $return
    }
}

$XF                                      = '/Xf "*.mp4" "*.mp3" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
$log                                     = "RoboCopy_$env:COMPUTERNAME"+"_"+"$env:UserName.log"
$Options                                 = "*.* /s /tee /Eta /timfix $XF /MIR /J /r:5 /w:2 /Xo /NDL /NJH /NJS /log+:$env:USERPROFILE\$log"

$folderNames                         = "Desktop", "Contacts", "Documents", "Favorites", "Pictures", "Videos", "Downloads", "AppData\Roaming\Thunderbird", "AppData\Roaming\Mozilla", "AppData\Roaming\Google"
$list                                = foreach ($folderName in $folderNames) {
    [PSCustomObject]@{
        Source                       = "$SourcePath\$folderName"
        Destination                  = "$DestinationPath\$folderName"
    }
}
$list | Export-Csv -Path "$env:TEMP\temp.csv" -Encoding UTF8 -Delimiter ';' -NoTypeInformation

$CSV                                 = Import-Csv -Path "$env:TEMP\temp.csv" -Encoding 'UTF8' -Delimiter ';'
$SourcePath                          = $env:USERPROFILE
$Name                                = FunctionMOT -string $SourcePath -character "\" -range Right
$DestinationPath                     = "D:\"
$DestinationPath                     = $DestinationPath+$Name
if (-not (Test-Path -Path $DestinationPath -PathType Container)) {
    New-Item -Path $DestinationPath -ItemType "directory"
    $result                          = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
    if ($result -eq "OK") {
#                Invoke-Expression $boom
        foreach ($Line in $CSV) {
            Copy-WithProgress -Source $($Line.Source) -Destination $($Line.Destination) -Verbose
        }
    }
}


Copy-WithProgress -Source "C:\ueser\T1" -Destination "D:\T1\" -Gap 200 -ReportGap 2000 -Verbose
