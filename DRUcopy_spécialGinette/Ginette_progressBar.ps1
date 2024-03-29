Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

<# Mise en page #>
# Convertir une image en Base64 -> [Convert]::ToBase64String((Get-Content "PATH" -Encoding Byte))
    $iconBase64                         = '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'
    $iconBytes                          = [Convert]::FromBase64String($iconBase64)
    $stream                             = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
# Fin

Function ChoixNOM {
    Param(
        [Parameter(Mandatory=$true)][string]$string
        , [Parameter(Mandatory=$true)][char]$character
        , [Parameter(Mandatory=$false)][ValidateSet("Right","Left")][string]$range
        , [Parameter(Mandatory=$false)][int]$afternumber
        , [Parameter(Mandatory=$false)][int]$tonumber
    )
    Process
    {
        [string]$return                  = ""

        if ($range -eq "Right")
        {
            $return                      = $string.Split("$character")[($string.Length - $string.Replace("$character","").Length)]
        }
        elseif ($range -eq "Left")
        {
            $return                      = $string.Split("$character")[0]
        }
        elseif ($tonumber -ne 0)
        {
            for ($i = $afternumber; $i -le ($afternumber + $tonumber); $i++)
            {
                $return                  += $string.Split("$character")[$i]
            }
        }
        else
        {
            $return                      = $string.Split("$character")[$afternumber]
        }

        return $return
    }
}
function Copy-WithProgress {
    [CmdletBinding()]
    param (
            [Parameter(Mandatory = $true)]
            [string] $Source
        , [Parameter(Mandatory = $true)]
            [string] $Destination
        , [int] $ReportGap = 200
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
    $CommonRobocopyParams = '/MIR /NP /NDL /NC /BYTES /NJH /NJS';
    #endregion Robocopy params

    #region Robocopy Staging
    Write-Verbose -Message 'Analyzing robocopy job ...';
    $StagingLogPath = '{0}\temp\{1} robocopy staging.log' -f $env:windir, (Get-Date -Format 'yyyy-MM-dd HH-mm-ss');

    $StagingArgumentList = '"{0}" "{1}" /LOG:"{2}" /L {3}' -f $Source, $Destination, $StagingLogPath, $CommonRobocopyParams;
    Write-Verbose -Message ('Staging arguments: {0}' -f $StagingArgumentList);
    Start-Process -Wait -FilePath robocopy.exe -ArgumentList $StagingArgumentList -NoNewWindow;
    # Get the total number of files that will be copied
    $StagingContent = Get-Content -Path $StagingLogPath;
    $TotalFileCount = $StagingContent.Count - 1;

    # Get the total number of bytes to be copied
    [RegEx]::Matches(($StagingContent -join "`n"), $RegexBytes) | ForEach-Object { $BytesTotal = 0; } { $BytesTotal += $_.Value; };
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
        Write-Verbose -Message ('Bytes copied: {0}' -f $BytesCopied);
        Write-Verbose -Message ('Files copied: {0}' -f $LogContent.Count);
        $Percentage = 0;
        if ($BytesCopied -gt 0) {
           $Percentage = (($BytesCopied/$BytesTotal)*100)
        }
        Write-Progress -Activity Robocopy -Status ("Copied {0} of {1} files; Copied {2} of {3} bytes" -f $CopiedFileCount, $TotalFileCount, $BytesCopied, $BytesTotal) -PercentComplete $Percentage
    }
    #endregion Progress loop

    #region Function output
    [PSCustomObject]@{
        BytesCopied = $BytesCopied;
        FilesCopied = $CopiedFileCount;
    };
    #endregion Function output
}

$XF                                      = '/Xf "*.mp4" "*.mp3" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
$log                                     = "RoboCopy_$env:COMPUTERNAME"+"_"+"$env:UserName.log"
$Options                                 = "*.* /s /tee /Eta /timfix $XF /MIR /J /r:5 /w:2 /Xo /L /log+:$env:USERPROFILE\$log"

# Définition de la fenêtre
    $Form                               = New-Object system.Windows.Forms.Form
    $Form.ClientSize                    = New-Object System.Drawing.Point(392,400)
    $form.Icon                          = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
    $Form.text                          = "DRUcopy"
    $Form.StartPosition                 = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $form.FormBorderStyle               = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $form.MaximizeBox                   = $false

    $Form.TopMost                       = $true

    $Sauvegarde                         = New-Object system.Windows.Forms.RadioButton
    $Sauvegarde.text                    = " Sauvegarde"
    $Sauvegarde.AutoSize                = $true
    $Sauvegarde.width                   = 200
    $Sauvegarde.height                  = 20
    $Sauvegarde.location                = New-Object System.Drawing.Point(145,41)
    $Sauvegarde.Font                    = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $Sauvegarde.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#000091")

    $Restauration                       = New-Object system.Windows.Forms.RadioButton
    $Restauration.text                  = " Restauration"
    $Restauration.AutoSize              = $true
    $Restauration.width                 = 200
    $Restauration.height                = 20
    $Restauration.location              = New-Object System.Drawing.Point(145,107)
    $Restauration.Font                  = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $Restauration.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#E1000F")

    $OKButton                           = New-Object system.Windows.Forms.Button
    $OKButton.text                      = "OK !"
    $OKButton.width                     = 130
    $OKButton.height                    = 30
    $OKButton.location                  = New-Object System.Drawing.Point(15,361)
    $OKButton.Font                      = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $OKButton.Add_Click({if ($Sauvegarde.Checked)
        {
            $SourcePath                          = $env:USERPROFILE
            $RootFolderDestinationPath           = "D:\"
            $DestinationPath                     = New-Object System.Windows.Forms.FolderBrowserDialog
            $DestinationPath.Description         = " /!\ Choisir un dossier de sauvegarde /!\ "
            $DestinationPath.ShowNewFolderButton = $true
            $DestinationPath.SelectedPath        = $RootFolderDestinationPath
            $DestinationPath.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
            $DestinationPath                     = $DestinationPath.SelectedPath
    
            $Name                                = ChoixNOM -string $SourcePath -character "\" -range Right
            $DestinationPath                     = $DestinationPath+$Name
    
            $folderSaved                         = "Desktop", "Contacts", "Documents", "Favorites", "Pictures", "Videos", "Downloads", "AppData\Roaming\Thunderbird", "AppData\Roaming\Mozilla", "AppData\Roaming\Google"
            $list                                = foreach ($folderName in $folderSaved)
            {
                [PSCustomObject]@{
                    Source                       = "$SourcePath\$folderName"
                    Destination                  = "$DestinationPath\$folderName"
                }
            }
            
            if (-not (Test-Path -Path $DestinationPath -PathType Container))
            {
                $alertMessage                    = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
                if($alertMessage -eq $null)
                {
                    [System.Windows.MessageBox]::Show("En cas de doutes, ne pas hésiter à contacter votre Administrateur.`r` `r`DSIGE-DRU")
                    break
                }
                elseif ($alertMessage -eq "OK")
                {
                        New-Item -Path $DestinationPath -ItemType "directory"
                        Stop-Process -Name "firefox","thunderbird" -Force -ErrorAction SilentlyContinue
                        $copiedCount                 = 0
                        $errorCount                  = 0
                        $list | ForEach-Object -ThrottleLimit 2 -Parallel {
                        try {
                            Start-Process -FilePath "Robocopy.exe" -ArgumentList "$($_.Source)", "$($_.Destination)", $Options -NoNewWindow -Wait
                            Start-Sleep -Milliseconds 100
                            $copiedCount++
                            $ProgressBar.Value   = ($copiedCount / $list.Count) * 100
                        } catch {
                            Write-Error "Une erreur est apparue en essayant de copier $($_.Source) to $($_.Destination)."
                            $errorCount++
                            Start-Sleep -Milliseconds 100
                            $copiedCount++
                            $ProgressBar.Value   = ($copiedCount / $list.Count) * 100    
                            Continue
                        }
                    }
                    if($errorCount -gt 0){
                        [System.Windows.MessageBox]::Show("La Sauvegarde s'est terminée avec $errorCount erreurs.`r`Merci contacter votre Administrateur.`r` `r`DSIGE-DRU")
                    }
                    else{
                        [System.Windows.MessageBox]::Show("La Sauvegarde s'est correctement déroulée.`r` `r`DSIGE-DRU")
                    }
                }
            }
            elseif (Test-Path -Path $DestinationPath -PathType Container)
            {
                $alertMessage                       = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
                if($alertMessage -eq $null)
                {
                [System.Windows.MessageBox]::Show("En cas de doutes, ne pas hésiter à contacter votre Administrateur.`r` `r`DSIGE-DRU")
                break
                }
                elseif ($alertMessage -eq "OK")
                {
                    Stop-Process -Name "firefox","thunderbird" -Force -ErrorAction SilentlyContinue
                    $copiedCount                    = 0
                    $errorCount                     = 0
                    $list | ForEach-Object -ThrottleLimit 2 -Parallel {
                        try {
                            Start-Process -FilePath "Robocopy.exe" -ArgumentList "$($_.Source)", "$($_.Destination)", $Options -NoNewWindow -Wait
                            Start-Sleep -Milliseconds 100
                            $copiedCount++
                            $ProgressBar.Value      = ($copiedCount / $list.Count) * 100
                        } catch {
                            Write-Error "Une erreur est apparue en essayant de copier $($_.Source) to $($_.Destination)."
                            $errorCount++
                            Start-Sleep -Milliseconds 100
                            $copiedCount++
                            $ProgressBar.Value      = ($copiedCount / $list.Count) * 100
                            Continue
                        }
                    }
                    if($errorCount -gt 0){
                        [System.Windows.MessageBox]::Show("La Sauvegarde s'est terminée avec $errorCount erreurs.`r`Merci contacter votre Administrateur.`r` `r`DSIGE-DRU")
                    }
                    else{
                        [System.Windows.MessageBox]::Show("La Sauvegarde s'est correctement déroulée.`r` `r`DSIGE-DRU")
                    }
                }
            }
        }
        elseif ($Restauration.Checked)
        {
            # Définition de la Source
            $RootFolderSourcePath                = "D:\"
            $SourcePath                          = New-Object System.Windows.Forms.FolderBrowserDialog
            $SourcePath.Description              = "/!\ Choisir la sauvegarde à restaurer /!\"
            $SourcePath.ShowNewFolderButton      = $true
            $SourcePath.SelectedPath             = $RootFolderSourcePath
            $SourcePath.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
            $SourcePath                          = $SourcePath.SelectedPath
        
            # Définition de la destination
            $DestinationPath                     = $env:USERPROFILE
    
            # Lancement de la copie
            $alertMessage                        = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
            if($alertMessage -eq $null)
            {
                [System.Windows.MessageBox]::Show("En cas de doutes, ne pas hésiter à contacter votre Administrateur.`r` `r`DSIGE-DRU")
                break
            }
            elseif ($alertMessage -eq "OK")
            {
                Stop-Process -Name "firefox","thunderbird" -Force -ErrorAction SilentlyContinue
                "Robocopy.exe $SourcePath $DestinationPath $Options"
                [System.Windows.MessageBox]::Show("La restauration s'est correctement déroulée.`r` `r`DSIGE-DRU")
            }
        }
        else
        {
            [System.Windows.MessageBox]::Show("Veuillez faire un choix s'il vous plaît.")
            [void]$Form.ShowDialog()
        }
    
        $messageFin                             = ' FINI !' * 1000
        Write-Host $messageFin
        
        pause})

    $CancelButton                       = New-Object system.Windows.Forms.Button
    $CancelButton.text                  = "STOPTOU"
    $CancelButton.width                 = 130
    $CancelButton.height                = 30
    $CancelButton.location              = New-Object System.Drawing.Point(249,361)
    $CancelButton.Font                  = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $CancelButton.Add_Click({((Stop-Process -Name powershell -Force));})

    $TextBox                            = New-Object system.Windows.Forms.TextBox
    $TextBox.multiline                  = $true
    $TextBox.UTF8Encoding
    $TextBox.text                       = "-> Le bouton 'Sauvegarde' sauvegardera votre profil utilisateur à l'endroit que vous sélectionnerez. Les fichiers vidéos, de musique, et d'installation (*.mp3, *.mp4, *.avi, *.tmp, *.mkv, *.iso et *.msi) ne seront pas conservés !`r`n`r`n -> Le bouton 'Restauration' rétablira le profil utilisateur que vous avez sauvegardé depuis l'endroit que vous sélectionnerez."
    $TextBox.width                      = 350
    $TextBox.height                     = 155
    $TextBox.enabled                    = $false
    $TextBox.location                   = New-Object System.Drawing.Point(20,180)
    $TextBox.Font                       = New-Object System.Drawing.Font('Arial',10)

    $ProgressBar                        = New-Object System.Windows.Forms.ProgressBar
    $ProgressBar.Maximum                = 100
    $ProgressBar.Minimum                = 0
    $ProgressBar.Step                   = 1
    $ProgressBar.Dock                   = [System.Windows.Forms.DockStyle]::Top

    $Form.AcceptButton                  = $OKButton
    $Form.CancelButton                  = $CancelButton
    $Form.controls.AddRange(@($Sauvegarde,$Restauration,$OKButton,$CancelButton,$TextBox,$ProgressBar))
    
    [void]$Form.ShowDialog()
<# Fin Mise en page #>