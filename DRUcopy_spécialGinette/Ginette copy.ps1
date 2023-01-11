Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

<# Logic #>

# Création de la fonction "FunctionMOT" (volée sur le web xD) pour la copie d'un dossier en ne récupérant QUE son nom
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

# Définition de diverses options et comportement de RoboCopy

    #$boom                                    = Get-Process -Name "firefox","thunderbird" | ForEach-Object {$_.Kill()}
    $XF                                      = '/Xf "*.mp4" "*.mp3" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
    $log                                     = "RoboCopy_$env:COMPUTERNAME"+"_"+"$env:UserName.log"
    $Options                                 = "*.* /s /tee /Eta /timfix $XF /MIR /J /r:5 /w:2 /Xo /NDL /NJH /NJS /L /log+:$env:USERPROFILE\$log"

<# Fin Logic #>

<# ########################################################################################## #>

<# Mise en page #>

# Convertir une image en Base64 -> [Convert]::ToBase64String((Get-Content "PATH" -Encoding Byte))

# Définition de la fenêtre
    $Form                               = New-Object system.Windows.Forms.Form
    $Form.ClientSize                    = New-Object System.Drawing.Point(392,400)
    $Form.text                          = "DRUcopy"
    $Form.StartPosition                 = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $Form.TopMost                       = $true

# RadioButton1
    $Sauvegarde                         = New-Object system.Windows.Forms.RadioButton
    $Sauvegarde.text                    = " Sauvegarde"
    $Sauvegarde.AutoSize                = $true
    $Sauvegarde.width                   = 200
    $Sauvegarde.height                  = 20
    $Sauvegarde.location                = New-Object System.Drawing.Point(145,41)
    $Sauvegarde.Font                    = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $Sauvegarde.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#000091")

# RadioButton2
    $Restauration                       = New-Object system.Windows.Forms.RadioButton
    $Restauration.text                  = " Restauration"
    $Restauration.AutoSize              = $true
    $Restauration.width                 = 200
    $Restauration.height                = 20
    $Restauration.location              = New-Object System.Drawing.Point(145,107)
    $Restauration.Font                  = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $Restauration.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#E1000F")

# OKButton
    $OKButton                           = New-Object system.Windows.Forms.Button
    $OKButton.text                      = "OK !"
    $OKButton.width                     = 130
    $OKButton.height                    = 30
    $OKButton.location                  = New-Object System.Drawing.Point(15,361)
    $OKButton.Font                      = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $OKButton.Add_Click({if ($Sauvegarde.Checked) {

        # Définition de la source
        $SourcePath                          = $env:USERPROFILE

        # Définition de la destination
        $RootFolderDestinationPath           = "D:\"
        $DestinationPath                     = New-Object System.Windows.Forms.FolderBrowserDialog
        $DestinationPath.Description         = " /!\ Choisir un dossier de sauvegarde /!\ "
        $DestinationPath.ShowNewFolderButton = $true
        $DestinationPath.SelectedPath        = $RootFolderDestinationPath
        $DestinationPath.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
        $DestinationPath                     = $DestinationPath.SelectedPath

        # Création du .CSV contenant les informations à sauvegarder
        $folderNames                         = "Desktop", "Contacts", "Documents", "Favorites", "Pictures", "Videos", "Downloads", "AppData\Roaming\Thunderbird", "AppData\Roaming\Mozilla", "AppData\Roaming\Google"
        $list                                = foreach ($folderName in $folderNames) {
            [PSCustomObject]@{
                Source                       = "$SourcePath\$folderName"
                Destination                  = "$DestinationPath\$folderName"
            }
        }
        $list | Export-Csv -Path "$env:TEMP\temp.csv" -Encoding UTF8 -Delimiter ';' -NoTypeInformation
        $CSV                                 = Import-Csv -Path "$env:TEMP\temp.csv" -Encoding 'UTF8' -Delimiter ';'

        # Vérification de la présence du dossier de destination et lancement de la copie
        $Name                                = FunctionMOT -string $SourcePath -character "\" -range Right
        $DestinationPath                     = $DestinationPath+$Name
        if (-not (Test-Path -Path $DestinationPath -PathType Container)) {
            New-Item -Path $DestinationPath -ItemType "directory"
            $result                          = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
            if ($result -eq "OK") {
#                Invoke-Expression $boom
                foreach ($Line in $CSV) {
                Robocopy.exe $($Line.Source) $($Line.Destination) $Options | ForEach-Object -Process {
                    $data = $_.Split([char]9);
                    if (($data.Count -gt 4) -and ("$($data[4])" -ne ""))
                    {
                        $file = "$($data[4])"
                        Write-Progress "Percentage $($data[0])" -Activity "Robocopy" -CurrentOperation "$($file)" -ErrorAction SilentlyContinue; 
                    }
                    else
                    {
                        Write-Progress "Percentage $($data[0])" -Activity "Robocopy" -CurrentOperation "$($file)"
                    }
                }
                # Robocopy has a bitmask set of exit codes, so only complain about failures:
                [int] $exitCode = $global:LastExitCode;
                [int] $someCopyErrors = $exitCode -band 8;
                [int] $seriousError = $exitCode -band 16;
                if (($someCopyErrors -ne 0) -or ($seriousError -ne 0)){
                    Write-Error "ERROR: robocopy failed with a non-successful exit code: $exitCode"
                    exit 1
                }
            }
        }
    }
    elseif (Test-Path -Path $DestinationPath -PathType Container) {
        $result                          = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
        if ($result -eq "OK") {
            Invoke-Expression $boom
            Robocopy.exe $SourcePath $DestinationPath $Options | ForEach-Object -Process {
                $data = $_.Split([char]9);
                if (($data.Count -gt 4) -and ("$($data[4])" -ne ""))
                {
                    $file = "$($data[4])"
                    Write-Progress "Percentage $($data[0])" -Activity "Robocopy" -CurrentOperation "$($file)" -ErrorAction SilentlyContinue; 
                }
                else
                {
                    Write-Progress "Percentage $($data[0])" -Activity "Robocopy" -CurrentOperation "$($file)"
                }
            }
            # Robocopy has a bitmask set of exit codes, so only complain about failures:
            [int] $exitCode = $global:LastExitCode;
            [int] $someCopyErrors = $exitCode -band 8;
            [int] $seriousError = $exitCode -band 16;
            if (($someCopyErrors -ne 0) -or ($seriousError -ne 0)){
                Write-Error "ERROR: robocopy failed with a non-successful exit code: $exitCode"
                exit 1
            }
        }
    }
}
elseif ($Restauration.Checked) {
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
        $result                          = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
        if ($result -eq "OK") {
            Invoke-Expression $boom
            Invoke-Expression $cmd
        }
    }
    else{
        [System.Windows.MessageBox]::Show("/!\ Aucune action sélectionnée /!\")
    }
})

# CancelButton
    $CancelButton                       = New-Object system.Windows.Forms.Button
    $CancelButton.text                  = "STOPTOU"
    $CancelButton.width                 = 130
    $CancelButton.height                = 30
    $CancelButton.location              = New-Object System.Drawing.Point(249,361)
    $CancelButton.Font                  = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
    $CancelButton.Add_Click({((Stop-Process -Name powershell -Force));})

# TextBox
    $TextBox                            = New-Object system.Windows.Forms.TextBox
    $TextBox.multiline                  = $true
    $TextBox.UTF8Encoding
    $TextBox.text = "-> Le bouton 'Sauvegarde' sauvegardera votre profil utilisateur à l'endroit que vous sélectionnerez. Les fichiers vidéos, de musique, et d'installation (*.mp3, *.mp4, *.avi, *.tmp, *.mkv, *.iso et *.msi) ne seront pas conservés !`r`n`r`n -> Le bouton 'Restauration' rétablira le profil utilisateur que vous avez sauvegardé depuis l'endroit que vous sélectionnerez."

    $TextBox.width                      = 350
    $TextBox.height                     = 145
    $TextBox.enabled                    = $false
    $TextBox.location                   = New-Object System.Drawing.Point(20,200)
    $TextBox.Font                       = New-Object System.Drawing.Font('Arial',10)

    $Form.AcceptButton                  = $OKButton
    $Form.CancelButton                  = $CancelButton
    $Form.controls.AddRange(@($Sauvegarde,$Restauration,$OKButton,$CancelButton,$TextBox))
    [void]$Form.ShowDialog()

<# Fin Mise en page #>