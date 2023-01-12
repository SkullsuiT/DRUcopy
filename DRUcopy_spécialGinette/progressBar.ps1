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

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = "File Copy Progress"
$form.Width = 600
$form.Height = 200
$form.StartPosition = "CenterScreen"

# Create a ProgressBar and add it to the form
$progressBar = New-Object Windows.Forms.ProgressBar
$progressBar.Width = 550
$progressBar.Height = 25
$progressBar.Left = 25
$progressBar.Top = 75
$form.Controls.Add($progressBar)

# Create labels to display the number of files and bytes copied
$fileLabel = New-Object Windows.Forms.Label
$fileLabel.Width = 250
$fileLabel.Height = 25
$fileLabel.Left = 25
$fileLabel.Top = 25
$fileLabel.Text = "Files Copied: 0"
$form.Controls.Add($fileLabel)

$byteLabel = New-Object Windows.Forms.Label
$byteLabel.Width = 250
$byteLabel.Height = 25
$byteLabel.Left = 325
$byteLabel.Top = 25
$byteLabel.Text = "Bytes Copied: 0"
$form.Controls.Add($byteLabel)

$form.ShowDialog()
    Copy-WithProgress -Source "C:\Users\T1" -Destination "D:\T1\" -Gap 200 -ReportGap 2000 -Verbose
