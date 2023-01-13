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
