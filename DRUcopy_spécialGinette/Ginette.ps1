# GUI permettant d'utiliser RoboCopy avec PowerShell
# JFDS_DSIGE-DRU_2022


    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
  
    $radioButtonItems = @('Sauvegarde', 'Restoration')

    $radioButtonGroup = New-Object System.Windows.Forms.GroupBox
    $radioButtonGroup.Location = New-Object System.Drawing.Point(10, 40)
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
    $formCHX.Text = 'DRUcopy'
    $labelCHX = New-Object System.Windows.Forms.Label
    $labelCHX.Location = New-Object System.Drawing.Point(10,20)

$formCHX.AutoSize = $true
$formCHX.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink

    $formCHX.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
    
    $formCHX.StartPosition = 'CenterScreen'
    $labelCHX.Text = 'Choisir une option :'
# Fin

# Définition du bouton "GO !"
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'GO !'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
# Fin
# Définition du bouton "STOPTOU"
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'STOPTOU'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$CancelButton.Add_Click({((Stop-Process -Name powershell -Force));})
# Fin
$layoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$layoutPanel.Dock = [System.Windows.Forms.DockStyle]::Fill

$OKButton.Anchor = [System.Windows.Forms.AnchorStyles]::None
$CancelButton.Anchor = [System.Windows.Forms.AnchorStyles]::None

# Calculer l'espacement entre le haut de la fenêtre et le haut du premier bouton
$buttonSpacing = ($formCHX.ClientSize.Height - $OKButton.Height) / 2

# Centrer horizontalement les boutons en utilisant l'espacement calculé
$OKButton.Left = ($formCHX.ClientSize.Width - $OKButton.Width - $CancelButton.Width - $buttonSpacing) / 2
$CancelButton.Left = $OKButton.Right + $buttonSpacing

# Placer les boutons au niveau du haut de la fenêtre
$OKButton.Top = $CancelButton.Top = $buttonSpacing



$formCHX.Controls.Add($OKButton)
$formCHX.Controls.Add($CancelButton)

$formCHX.Controls.Add($labelCHX)
$formCHX.Controls.Add($radioButtonGroup)

    $formCHX.ShowDialog()