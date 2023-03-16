Add-Type -AssemblyName PresentationFramework

$sourceFolders = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Contacts",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Favorites",
    "$env:USERPROFILE\Pictures",
    "$env:USERPROFILE\Downloads",
    "$env:APPDATA\Thunderbird",
    "$env:APPDATA\Mozilla",
    "$env:APPDATA\Google"
)

function Show-BackupDialog {
    $dialog = New-Object System.Windows.Window
    $dialog.Title = "DRU-copy - Backup"
    $dialog.Width = 400
    $dialog.Height = 250
    $dialog.ResizeMode = "NoResize"

    $label1 = New-Object System.Windows.Controls.Label
    $label1.Content = "Select backup destination:"
    $label1.Margin = "10,10,0,0"

    $textbox1 = New-Object System.Windows.Controls.TextBox
    $textbox1.Name = "BackupLocation"
    $textbox1.Width = 250
    $textbox1.Margin = "10,30,0,0"

    $button1 = New-Object System.Windows.Controls.Button
    $button1.Content = "Browse..."
    $button1.Width = 100
    $button1.Margin = "270,30,0,0"
    $button1.Add_Click({
        $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $dialog.SelectedPath = $textbox1.Text
        if ($dialog.ShowDialog() -eq "OK") {
            $textbox1.Text = $dialog.SelectedPath
        }
    })

    $checkbox1 = New-Object System.Windows.Controls.CheckBox
    $checkbox1.Name = "ExcludeMP4"
    $checkbox1.Content = "Exclude .mp4 files"
    $checkbox1.IsChecked = $true
    $checkbox1.Margin = "10,60,0,0"

    $checkbox2 = New-Object System.Windows.Controls.CheckBox
    $checkbox2.Name = "ExcludeMP3"
    $checkbox2.Content = "Exclude .mp3 files"
    $checkbox2.IsChecked = $true
    $checkbox2.Margin = "10,90,0,0"

    $checkbox3 = New-Object System.Windows.Controls.CheckBox
    $checkbox3.Name = "ExcludeAVI"
    $checkbox3.Content = "Exclude .avi files"
    $checkbox3.IsChecked = $true
    $checkbox3.Margin = "10,120,0,0"

    $checkbox4 = New-Object System.Windows.Controls.CheckBox
    $checkbox4.Name = "ExcludeTMP"
    $checkbox4.Content = "Exclude .tmp files"
    $checkbox4.IsChecked = $true
    $checkbox4.Margin = "10,150,0,0"

    $checkbox5 = New-Object System.Windows.Controls.CheckBox
    $checkbox5.Name = "ExcludeMKV"
    $checkbox5.Content = "Exclude .mkv files"
    $checkbox5.IsChecked = $true
    $checkbox5.Margin = "10,180,0,0"

    $checkbox6 = New-Object System.Windows.Controls.CheckBox
    $checkbox6.Name = "ExcludeISO"
    $checkbox6.Content = "Exclude .iso files"
    $checkbox6.IsChecked = $true
    $checkbox6.Margin = "150,60,0,0"

    $checkbox7 = New-Object System.Windows.Controls.CheckBox
    $checkbox7.Name = "ExcludeMSI"
    $checkbox7.Content = "Exclude .msi"
    $checkbox7.IsChecked = $true
    $checkbox7.Margin = "150,90,0,0"

