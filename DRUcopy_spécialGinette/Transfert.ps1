# GUI permettant d'utiliser RoboCopy avec PowerShell
# JFDS_DSIGE-DRU_2022

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

# Convertir une image en Base64 -> [Convert]::ToBase64String((Get-Content "PATH" -Encoding Byte))
# Cette chaîne base64 contient les octets qui composent l'icône Marianne en 32x32 pixels
    $iconBase64 = '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'
    $iconBytes = [Convert]::FromBase64String($iconBase64)
# Fin
# Initialise un flux de mémoire contenant les octets
    $stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
# Fin

# Localisation du .LOG pour RoboCopy
    $log = "robocopy_$env:COMPUTERNAME"+"_"+"$env:UserName.log"
# Fin

$stopProcessCommand = "Stop-Process -Name powershell -Force"

# Création de la fonction "Extract-String" (volée sur le web xD) pour la copie d'un dossier en ne récupérant QUE son nom
Function Extract-String {
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
# Fin

# Définition des boutons "GO !" et "STOPTOU"
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(75,120)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = 'GO !'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
# Fin
# Définition du bouton "STOPTOU"
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(150,120)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = 'STOPTOU'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $CancelButton.Add_Click({((Invoke-Expression $stopProcessCommand));})
# Fin

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>

# Création du WinForm pour définir l'utilisation du .EXE
    # Dimensionnement de la fenêtre
        $formCHX = New-Object System.Windows.Forms.Form
        $formCHX.Text = 'Quoi faire ?'
        $formCHX.Size = New-Object System.Drawing.Size(300,200)
        $formCHX.StartPosition = 'CenterScreen'
        $formCHX.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
    # Fin
    # Utilisation du bouton "GO"
        $formCHX.AcceptButton = $OKButton
        $formCHX.Controls.Add($OKButton)
    # Fin
    # Utilisation du bouton "STOPTOU"
        $formCHX.CancelButton = $CancelButton
        $formCHX.Controls.Add($CancelButton)
    # Dimensionnement de l'encadré
        $labelCHX = New-Object System.Windows.Forms.Label
        $labelCHX.Location = New-Object System.Drawing.Point(10,20)
        $labelCHX.Size = New-Object System.Drawing.Size(280,20)
        $labelCHX.Text = 'Choisir une option :'
        $formCHX.Controls.Add($labelCHX)
    # Fin
    $listBoxCHX = New-Object System.Windows.Forms.Listbox

$listBoxCHX.Location = New-Object System.Drawing.Point(10,40)
$listBoxCHX.Size = New-Object System.Drawing.Size(260,20)
$listBoxCHX.Height = 90
$listBoxCHX.SelectionMode = 'MultiExtended'

$items = @('user backup', 'user restore', 'copy folder', '7-zip')

foreach ($item in $items) {
    [void] $listBoxCHX.Items.Add($item)
}



    # Fin
    # Afficache du WinForm 
    $formCHX.Controls.Add($listBoxCHX)
    $formCHX.Topmost = $true
        $formCHX.ShowDialog()
    # Fin
# Fin

# Option "user backup" sélectionnée
    # Création du WinForm pour choisir le nombre de threads de RoboCopy /MT:n
        # Dimensionnement de la fenêtre
        if ($listBoxCHX.SelectedItem.Length.Equals(11))
        {
            $formMT = New-Object System.Windows.Forms.Form
            $formMT.Text = 'Nombre de threads'
            $formMT.Size = New-Object System.Drawing.Size(300,200)
            $formMT.StartPosition = 'CenterScreen'
            $formMT.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
        # Fin
        # Utilisation du bouton "GO !"
            $formMT.AcceptButton = $OKButton
            $formMT.Controls.Add($OKButton)
        # Fin
        # Utilisation du bouton "STOPTOU"
            $formMT.CancelButton = $CancelButton
            $formMT.Controls.Add($CancelButton)
        # Fin
        # Dimensionnement de l'encadré
            $labelMT = New-Object System.Windows.Forms.Label
            $labelMT.Location = New-Object System.Drawing.Point(10,20)
            $labelMT.Size = New-Object System.Drawing.Size(280,20)
            $labelMT.Text = 'Choisir combien de threads allouer à la copie :'
            $formMT.Controls.Add($labelMT)
        # Fin
        # Taille de la "Listbox"
            $listBoxMT = New-Object System.Windows.Forms.Listbox
            $listBoxMT.Location = New-Object System.Drawing.Point(10,40)
            $listBoxMT.Size = New-Object System.Drawing.Size(260,20)
            $listBoxMT.Height = 90
            $listBoxMT.SelectionMode = 'MultiExtended'
        # Fin
        # Définition du contenu de la "Listbox"
            [void] $listBoxMT.Items.Add('8')
            [void] $listBoxMT.Items.Add('16')
            [void] $listBoxMT.Items.Add('32')
            [void] $listBoxMT.Items.Add('64')
            [void] $listBoxMT.Items.Add('128')
        # Fin
        # Add de la "Listbox" à l'encadré
            $formMT.Controls.Add($listBoxMT)
            $formMT.Topmost = $true
        # Fin
        # Afficache du WinForm 
            $formMT.ShowDialog()
        # Fin
        #Traduction du choix utilisateur pour RoboCopy
            $MT = '/MT:'+$listBox.SelectedItem
        # Fin
    # Fin
<# 
    # Création du WinForm permettant à robocopy d'exclure des extensions de fichiers /Xf
        # Dimensionnement de la fenêtre
            $formXF = New-Object System.Windows.Forms.Form
            $formXF.Text = 'Quoi faire ?'
            $formXF.Size = New-Object System.Drawing.Size(300,200)
            $formXF.StartPosition = 'CenterScreen'
            $formXF.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
        # Fin
        # Utilisation du bouton "GO !"
            $formXF.AcceptButton = $OKButton
            $formXF.Controls.Add($OKButton)
        # Fin
        # Utilisation du bouton "STOPTOU"
            $formXF.CancelButton = $CancelButton
            $formXF.Controls.Add($CancelButton)
        # Fin
        # Dimensionnement de l'encadré
            $labelXF = New-Object System.Windows.Forms.Label
            $labelXF.Location = New-Object System.Drawing.Point(10,20)
            $labelXF.Size = New-Object System.Drawing.Size(280,20)
            $labelXF.Text = 'Choisir une option :'
            $formXF.Controls.Add($labelXF)
        # Fin
        # Taille de la "Listbox"
            $listBoxXF = New-Object System.Windows.Forms.Listbox
            $listBoxXF.Location = New-Object System.Drawing.Point(10,40)
            $listBoxXF.Size = New-Object System.Drawing.Size(260,20)
            $listBoxXF.Height = 90
            $listBoxXF.SelectionMode = 'MultiExtended'
        # Fin
        # Définitio du contenu de la "Listbox"
            [void] $listBoxXF.Items.Add('Empty')
            [void] $listBoxXF.Items.Add('*.EXE')
            [void] $listBoxXF.Items.Add('*.ISO')
            [void] $listBoxXF.Items.Add('*.TMP')
        # Fin
        # Ajout de la "Listbox" à l'encadré
            $formXF.Controls.Add($listBoxXF)
            $formXF.Topmost = $true
        # Fin
        # Afficache du WinForm 
            $formXF.ShowDialog()
        # Fin
        # Vérification et incrémentation de /Xf
            if ($formXF.SelectedItem -ne "*EXE", "*.ISO", "*.TMP")
            {
                $XF = ""
            }
            else
            {
                $XF = '/Xf '+$listBoxXF.SelectedItem
            }
        # Fin
    # Fin
#>

    # Définition des options RoboCopy
        $XF = '/Xf "*.mp4" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
        $Options = "*.* /s   /tee /Eta   /timfix $MT $XF /MIR /J /r:5 /w:2 /Xo /log+:$env:USERPROFILE\$log"
    # Fin

    # Définition de la Source, de la Destination ainsi que de leur validité
        # Définition de la source
            $RootFolderUB = "C:\Users\"
            $FolderBrowserUB = New-Object System.Windows.Forms.FolderBrowserDialog
            $FolderBrowserUB.Description = "/!\ User backup /!\"
            $FolderBrowserUB.ShowNewFolderButton = $true
            $FolderBrowserUB.SelectedPath = $RootFolderUB
            $FolderBrowserUB.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

            $SourcePath = $FolderBrowserUB.SelectedPath
        # Fin
        # Définition de la destination
            $RootFolderFP = "DesktopDirectory"
            $FolderBrowserFP = New-Object System.Windows.Forms.FolderBrowserDialog
            $FolderBrowserFP.Description = "/!\Choisir un dossier/!\"
            $FolderBrowserFP.ShowNewFolderButton = $true
            $FolderBrowserFP.SelectedPath = $RootFolderFP
            $FolderBrowserFP.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

            $DestinationPath = $FolderBrowserFP.SelectedPath
        # Fin
        # Test du bouton "Cancel"
            if (($SourcePath -eq "C:\Users\") -or ($DestinationPath -eq "DesktopDirectory"))
            {
                Invoke-Expression $stopProcessCommand
            }
        # Fin
    # Fin

        # Récupération du .CSV pour RoboCpoy
            $CSV = Import-Csv -Path "$pwd\Transfert.csv" -Encoding 'UTF8' -Delimiter ','
        # Fin
            $Name = Extract-String -string $SourcePath -character "\" -range Right # Pour le .CSV
        # Lecture du .CSV et début de RoboCopy
            foreach ($Line in $CSV)
            {
                $cmd = "Robocopy.exe $($Line.Source) $($Line.Destination) $Options"
                Invoke-Expression $cmd
            }
        #Fin
            
        }
        # Fin
# Fin

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>

# Option de 'user restore' sélectionnée
    if ($listBoxCHX.SelectedItem.Length.Equals(12))
    {
    # Définition de la Source, de la Destination ainsi que de leur validité
        # Définition de la source
        $RootFolderFP = "DesktopDirectory"
        $FolderBrowserFP = New-Object System.Windows.Forms.FolderBrowserDialog
        $FolderBrowserFP.Description = "/!\Choisir un dossier/!\"
        $FolderBrowserFP.ShowNewFolderButton = $true
        $FolderBrowserFP.SelectedPath = $RootFolderFP
        $FolderBrowserFP.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

        $SourcePathRESTORE = $FolderBrowserFP.SelectedPath
        # Fin
        # Définition de la destination
        $RootFolderUR = "C:\Users\"
        $FolderBrowserUR = New-Object System.Windows.Forms.FolderBrowserDialog
        $FolderBrowserUR.Description = "/!\ User restore /!\"
        $FolderBrowserUR.ShowNewFolderButton = $true
        $FolderBrowserUR.SelectedPath = $RootFolderUR
        $FolderBrowserUR.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
        
        $DestinationPathRESTORE = $FolderBrowserUR.SelectedPath
        # Fin
        # Test du bouton "Cancel"
        if (($SourcePathRESTORE -eq "DesktopDirectory") -or ($DestinationPathRESTORE -eq "C:\Users\"))
        {
            Invoke-Expression $stopProcessCommand
        }
        # Fin
    # Définition des options RoboCopy
        $XF = '/Xf "*.mp4" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
        $Options = "*.* /s   /tee /Eta   /timfix /MT:8 $XF /MIR /J /r:5 /w:2 /Xo /log+:$env:USERPROFILE\$log"
    # Fin
    # Fin
        $cmd = "Robocopy.exe $SourcePathRESTORE $DestinationPathRESTORE $Options"
        Invoke-Expression $cmd
    }
# Fin

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>

# Option de 'copy folder' sélectionnée
    if ($listBoxCHX.SelectedItem.Length.Equals(13))
    {
    # Définition de la source
        $RootFolderCopySRC = "DesktopDirectory"
        $FolderBrowserCopySRC = New-Object System.Windows.Forms.FolderBrowserDialog
        $FolderBrowserCopySRC.Description = "/!\Choisir un dossier/!\"
        $FolderBrowserCopySRC.ShowNewFolderButton = $true
        $FolderBrowserCopySRC.SelectedPath = $RootFolderCopySRC
        $FolderBrowserCopySRC.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

        $SourcePathCOPY = $FolderBrowserCopySRC.SelectedPath
    # Fin
    # Définition de la destination
        $RootFolderCopyDEST = "DesktopDirectory"
        $FolderBrowserCopyDEST = New-Object System.Windows.Forms.FolderBrowserDialog
        $FolderBrowserCopyDEST.Description = "/!\ User restore /!\"
        $FolderBrowserCopyDEST.ShowNewFolderButton = $true
        $FolderBrowserCopyDEST.SelectedPath = $RootFolderCopyDEST
        $FolderBrowserCopyDEST.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
        
        $DestinationPathCOPY = $FolderBrowserCopyDEST.SelectedPath
    # Fin
    # Test du bouton "Cancel"
        if (($SourcePathCOPY -eq "DesktopDirectory") -or ($DestinationPathCOPY -eq "DesktopDirectory"))
        {
            Invoke-Expression $stopProcessCommand
        }
    # Fin
    # Fin
    # Créer le dossier de destination  
            $Name = Extract-String -string $SourcePathCOPY -character "\" -range Right
            New-Item -Path $DestinationPathCOPY -ItemType "directory" -Name $Name
            $DestinationPathCOPY = "$DestinationPathCOPY\$Name"
    # Fin
    # Définition des options RoboCopy
        $XF = '/Xf "*.mp4" "*.avi" "*.tmp" "*.mkv" "*.iso" "*.msi"'
        $Options = "*.* /s   /tee /Eta   /timfix /MT:8 $XF /MIR /J /r:5 /w:2 /Xo /log+:$env:USERPROFILE\$log"
    # Fin
    # Début de RoboCopy
            $cmd = "Robocopy.exe $SourcePathCOPY $DestinationPathCOPY $Options"
            Invoke-Expression $cmd
    # Fin
    }
# Fin

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>

# Option "7-zip" sélectionnée
    if ($listBoxCHX.SelectedItem.Length.Equals(14))
    {
    # Définition de la Source, de la Destination ainsi que de leur validité
        # Définition de la source
        $RootFolder7zSRC = "DesktopDirectory"
        $FolderBrowser7zSRC = New-Object System.Windows.Forms.FolderBrowserDialog
        $FolderBrowser7zSRC.Description = "/!\Choisir un dossier/!\"
        $FolderBrowser7zSRC.ShowNewFolderButton = $true
        $FolderBrowser7zSRC.SelectedPath = $RootFolder7zSRC
        $FolderBrowser7zSRC.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))

        $SourcePath7z = $FolderBrowser7zSRC.SelectedPath
        # Fin
        # Définition de la destination
        $RootFolder7zDEST = "DesktopDirectory"
        $FolderBrowser7zDEST = New-Object System.Windows.Forms.FolderBrowserDialog
        $FolderBrowser7zDEST.Description = "/!\Choisir un dossier/!\"
        $FolderBrowser7zDEST.ShowNewFolderButton = $true
        $FolderBrowser7zDEST.SelectedPath = $RootFolder7zDEST
        $FolderBrowser7zDEST.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true}))
        
        $DestinationPath7z = $FolderBrowser7zDEST.SelectedPath
        # Fin
        # Test du bouton "Cancel"
        if (($SourcePath7z -eq "DesktopDirectory") -or ($DestinationPath7z -eq "DesktopDirectory"))
        {
            Invoke-Expression $stopProcessCommand
        }
        # Fin
    # Fin
        # Utilisation de 7-zip
        $7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
        if (($SourcePath7z -eq "Cancel") -or ($DestinationPath7z -eq "Cancel"))
        {
            Invoke-Expression $stopProcessCommand
        }
        if (-not (Test-Path -Path $7zipPath -PathType Leaf))
        {
            throw "7 zip file '$7zipPath' introuvable, veuillez l'installer !"
        }
        else
        {
            $Name = Extract-String -string $SourcePath7z -character "\" -range Right
            function create-7zip ([String] $aDirectory, [String] $aZipfile)
            {
                [string]$pathToZipExe = "$($Env:ProgramFiles)\7-Zip\7z.exe";
                [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r", "-mx9", "-mmt";
                & $pathToZipExe $arguments;
            }
            create-7zip $SourcePath7z $DestinationPath7z\$Name.7z
        }
    }
        # Fin

# Fin

<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>
<# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #>

$finishMessage = "FINI ! "
$numMessages = 100

for ($i = 0; $i -lt $numMessages; $i++) {
    Write-Host $finishMessage
}

pause
# JFDS_DSIGE-DRU_2022