Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()


<# Mise en page #>

# Convertir une image en Base64 -> [Convert]::ToBase64String((Get-Content "PATH" -Encoding Byte))
    $iconBase64                         = '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'
    $iconBytes                          = [Convert]::FromBase64String($iconBase64)
    $stream                             = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)

# Définition de la fenêtre
    $Form                               = New-Object system.Windows.Forms.Form
    $Form.ClientSize                    = New-Object System.Drawing.Point(392,400)
    $form.Icon                          = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
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
    $OKButton.DialogResult              = [System.Windows.Forms.DialogResult]::OK

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

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>

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
    $Options                                 = "*.* /s /tee /Eta /timfix /MT:8 $XF /MIR /J /r:5 /w:2 /Xo /log+:$env:USERPROFILE\$log"
    $cmdR                                    = "Robocopy.exe $SourcePath $DestinationPath $Options"

    # Vérification du 'RadioButton' et lancement de la copie
    if ($Sauvegarde.Checked) {

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
                Invoke-Expression $boom
                foreach ($Line in $CSV) {
                    $jobs += Start-Job -ScriptBlock {
                        param($Line, $Options)
                        $cmd = "Robocopy.exe $($Line.Source) $($Line.Destination) $Options /L"
                        Invoke-Expression $cmd
                    } -ArgumentList $Line, $Options
                }
                $total = $jobs.Count
                while ($jobs) {
                    $pending = $jobs | Where-Object { $_.State -eq 'Running' }
                    $completed = $jobs.Count - $pending.Count
                    $percent = [int]($completed / $total * 100)
                    Write-Progress -Activity "Copying files" -Status "$completed out of $total" -PercentComplete $percent
                    $jobs = Get-Job -State Running
                    Start-Sleep -Seconds 1
                }   
            }
        }
        elseif (New-Item -Path $DestinationPath -ItemType "directory") {
            $result                          = [System.Windows.MessageBox]::Show("Veuillez ne pas utiliser Firefox ainsi que Thunderbird durant la durée de la copie (15-20 min).`r` `r`Merci d'avance. `r`DSIGE-DRU")            
            if ($result -eq "OK") {
                Invoke-Expression $boom
                $cmdR                                    = "Robocopy.exe $SourcePath $DestinationPath $Options /L"
                Invoke-Expression $cmdR
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

<# Fin Logic #>