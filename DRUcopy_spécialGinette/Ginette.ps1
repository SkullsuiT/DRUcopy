Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Mise en page

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(392,400)
$Form.text                       = "DRUcopy"
$Form.StartPosition              = [System.Windows.Forms.FormStartPosition]::CenterScreen
$Form.TopMost                    = $true

$Sauvegarde                      = New-Object system.Windows.Forms.RadioButton
$Sauvegarde.text                 = "Sauvegarde"
$Sauvegarde.AutoSize             = $true
$Sauvegarde.width                = 200
$Sauvegarde.height               = 20
$Sauvegarde.location             = New-Object System.Drawing.Point(145,108)
$Sauvegarde.Font                 = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Sauvegarde.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("#00c7fc")

$RadioButton2                    = New-Object system.Windows.Forms.RadioButton
$RadioButton2.text               = "Restauration"
$RadioButton2.AutoSize           = $true
$RadioButton2.width              = 200
$RadioButton2.height             = 20
$RadioButton2.location           = New-Object System.Drawing.Point(145,174)
$RadioButton2.Font               = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$RadioButton2.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#ff0000")

$OK                              = New-Object system.Windows.Forms.Button
$OK.text                         = "OK !"
$OK.width                        = 130
$OK.height                       = 30
$OK.location                     = New-Object System.Drawing.Point(15,327)
$OK.Font                         = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ProgressBar1                    = New-Object system.Windows.Forms.ProgressBar
$ProgressBar1.width              = 367
$ProgressBar1.height             = 23
$ProgressBar1.location           = New-Object System.Drawing.Point(14,367)

$Cancel                          = New-Object system.Windows.Forms.Button
$Cancel.text                     = "STOPTOU"
$Cancel.width                    = 130
$Cancel.height                   = 30
$Cancel.location                 = New-Object System.Drawing.Point(249,327)
$Cancel.Font                     = New-Object System.Drawing.Font('Marianne',11,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Form.controls.AddRange(@($Sauvegarde,$RadioButton2,$OK,$ProgressBar1,$Cancel))

# Fin mise en page

# Logic 



# Fin Logic

[void]$Form.ShowDialog()