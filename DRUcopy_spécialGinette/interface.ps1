Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Création de la fenêtre de l'interface utilisateur
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Ma première interface utilisateur en PowerShell"
$Form.Size = New-Object System.Drawing.Size(300,200)

# Création du bouton OK
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$Form.Close()})
$Form.Controls.Add($OKButton)

# Création du bouton Annuler
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Annuler"
$CancelButton.Add_Click({$Form.Close()})
$Form.Controls.Add($CancelButton)

$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Location = New-Object System.Drawing.Size(10,10)
$TextBox.Size = New-Object System.Drawing.Size(200,20)
$Form.Controls.Add($TextBox)


# Affiche la fenêtre de l'interface utilisateur
$Form.ShowDialog()
