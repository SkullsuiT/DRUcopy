# GUI permettant d'utiliser RoboCopy avec PowerShell
# JFDS_DSIGE-DRU_2022


    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
  
    $radioButtonItems = @('Sauvegarde', 'Restoration')

    $radioButtonGroup = New-Object System.Windows.Forms.GroupBox
    $radioButtonGroup.Location = New-Object System.Drawing.Point(10, 40)
    $radioButtonGroup.Size = New-Object System.Drawing.Size(260, 130)
    $radioButtonGroup.AutoSize = $true
    $radioButtonGroup.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
    $y = 10
    
    foreach ($radioButtonItem in $radioButtonItems)
    {
    $radioButton = New-Object System.Windows.Forms.RadioButton
    $radioButton.Text = $radioButtonItem
    $radioButton.Location = New-Object System.Drawing.Point(10, $y)
    $radioButtonGroup.Controls.Add($radioButton)
    $y += 25
    }

# Création du WinForm pour définir l'utilisation du .EXE
    # Dimensionnement de la fenêtre
    $formCHX = New-Object System.Windows.Forms.Form
    $formCHX.Text = 'Quoi faire ?'
    $labelCHX = New-Object System.Windows.Forms.Label
    $labelCHX.Location = New-Object System.Drawing.Point(10,20)

    $formCHX.AutoSize = $true
    $formCHX.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
    
    $formCHX.StartPosition = 'CenterScreen'
    $labelCHX.Text = 'Choisir une option :'
# Fin

# Définition du bouton "GO !"
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Size = New-Object System.Drawing.Size(75, 23)
$OKButton.Text = 'GO !'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$OKButton.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom
# Fin
# Définition du bouton "STOPTOU"
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Size = New-Object System.Drawing.Size(75, 23)
$CancelButton.Text = 'STOPTOU'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$CancelButton.Add_Click({((Stop-Process -Name powershell -Force));})
$CancelButton.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom
# Fin


# Création du layout pannel

$layoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$layoutPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$layoutPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$layoutPanel.AutoSize = $true



$OKButton.Dock = [System.Windows.Forms.DockStyle]::Bottom

$CancelButton.Dock = [System.Windows.Forms.DockStyle]::Bottom

# Création du layout pannel
$layoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$layoutPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$layoutPanel.Controls.Add($radioButtonGroup)
$layoutPanel.Controls.Add($OKButton)
$layoutPanel.Controls.Add($CancelButton)


# Utilisation du bouton "STOPTOU"
    $formCHX.Controls.Add($layoutPanel)
    $formCHX.Controls.Add($labelCHX)

    $formCHX.ShowDialog()