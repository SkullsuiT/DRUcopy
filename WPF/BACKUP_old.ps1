Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore,PresentationFramework
#https://pbs.twimg.com/profile_images/1518539949699702785/01XDvAkE_bigger.jpg

# Convertir une image en Base64 -> [Convert]::ToBase64String((Get-Content "PATH" -Encoding Byte))
# Cette chaîne base64 contient les octets qui composent l'icône Marienne en 32x32 pixels
$iconBase64 = '/9j/4AAQSkZJRgABAQAAAQABAAD/4gKgSUNDX1BST0ZJTEUAAQEAAAKQbGNtcwQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwQVBQTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9tYAAQAAAADTLWxjbXMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtkZXNjAAABCAAAADhjcHJ0AAABQAAAAE53dHB0AAABkAAAABRjaGFkAAABpAAAACxyWFlaAAAB0AAAABRiWFlaAAAB5AAAABRnWFlaAAAB+AAAABRyVFJDAAACDAAAACBnVFJDAAACLAAAACBiVFJDAAACTAAAACBjaHJtAAACbAAAACRtbHVjAAAAAAAAAAEAAAAMZW5VUwAAABwAAAAcAHMAUgBHAEIAIABiAHUAaQBsAHQALQBpAG4AAG1sdWMAAAAAAAAAAQAAAAxlblVTAAAAMgAAABwATgBvACAAYwBvAHAAeQByAGkAZwBoAHQALAAgAHUAcwBlACAAZgByAGUAZQBsAHkAAAAAWFlaIAAAAAAAAPbWAAEAAAAA0y1zZjMyAAAAAAABDEoAAAXj///zKgAAB5sAAP2H///7ov///aMAAAPYAADAlFhZWiAAAAAAAABvlAAAOO4AAAOQWFlaIAAAAAAAACSdAAAPgwAAtr5YWVogAAAAAAAAYqUAALeQAAAY3nBhcmEAAAAAAAMAAAACZmYAAPKnAAANWQAAE9AAAApbcGFyYQAAAAAAAwAAAAJmZgAA8qcAAA1ZAAAT0AAACltwYXJhAAAAAAADAAAAAmZmAADypwAADVkAABPQAAAKW2Nocm0AAAAAAAMAAAAAo9cAAFR7AABMzQAAmZoAACZmAAAPXP/bAEMABQMEBAQDBQQEBAUFBQYHDAgHBwcHDwsLCQwRDxISEQ8RERMWHBcTFBoVEREYIRgaHR0fHx8TFyIkIh4kHB4fHv/bAEMBBQUFBwYHDggIDh4UERQeHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHv/CABEIAEkASQMBIgACEQEDEQH/xAAcAAACAwADAQAAAAAAAAAAAAAABwQFBgEDCAL/xAAbAQABBQEBAAAAAAAAAAAAAAAFAQIDBAYAB//aAAwDAQACEAMQAAABcvSedLjd3r84ynoAUH8dHyn4SbqIkuUaoVNa0ewreveaK9yU4A1RPtBfQGIjc84O+Mgtbu3WWnyTc1OfvxEnIESmd0C5iILOT0uKhuKGkbit1PmfS1ybTcYbc5ekQS5awxnoeictZZksAASjQDuAO4iSxFAFT//EACIQAAICAwABBAMAAAAAAAAAAAMEAQUAAgYQERUgMBIiI//aAAgBAQABBQLDFGET3UlOxU17OnmcXOJgfg5RhD0V0a0Y4umhUHloUmDqRmjsE2BtL539jOLzpB49PT4deCB2XJOyFzL8u57nKBnVuo8v6k2X6dHcSYd5EX3UGbOIpk1rubtlaJavBPw6FmFq7PzLlxfIq4GtLeO04VkRRPr5iYnO2J+ums77+yjzp6VUzorqpVCm8/cGSVEmtnWukXX0JvpJCbk25VOWLDHVhOKpcd/dJRdMHi9qfcYerHU8SVM4xWpjRU+hdYC8/Z//xAAlEQACAQIFAwUAAAAAAAAAAAABAgMABAUQERMxEiFRFCAiMkH/2gAIAQMBAT8BZtKHk5WNgLxWCt8xwKZSp6TTHU54DLt3i9+e1Y/YMZhJGOchlhcG9dohq/v4rTp3P2iDr2oCsNeFLlWm+tLNCy7oI081it76ycuOBx7AxA0y/8QAIhEAAgICAQQDAQAAAAAAAAAAAQIAAwQRMRASIWETIJEi/9oACAECAQE/AcTEbJb1Mp60Px0/vSyzsPqczEpFdIWOpVip6ZA2kx7PGjKwXXvO0978fkuO3J6WtpCZXWX4mNfU1er24mReLDpBoS0Er/M0eJVX2L9v/8QANBAAAgECAwUFBwMFAAAAAAAAAQIDABEEEjEFEBMhIiBBUWFxFBUjUoGhwTAzkWKC0eHw/9oACAEBAAY/AqaWV1RF1JoYTY8HEdjYOw19BQn2jinxGI8L9Ceg7HEicMu9pZWCoguSasLphlPQn5NDaE4+NKvSPlXsFFleI9zKdKyiVZPnUHX/AHSzxG6tuTZsbf1y/gVGZBdMwzelctOyJRpKl/rXsrHol08m3YqR9eIf43YaZWucgDeo17B4UaO/cGrDSLzSO4fyJpZF1U3FaiuFtHYZh9EU/fv/AJoyYUrARqVOUj1BqX3fM0g5LJ1XUt/nssWh4ofotfd308M2GlmscpGUZSfrXFwWBGCwx1a/T/3pQ2dhznMYvIR4+fn2ORvWHi6ed286CjUm273jicUMNBl+LyuSfKlw8T7SliUWAzZR9qGC2XH7BhE/cZdbevjSwQiyr49+5MPE2Uy3zEeFXR2U+RrNI7O3ixvQmI+HD1fXu3Ph51zI4saY4zE3iB6RHqw/FCHDRLGg8N6MsvDkTS45GrzRHL868xQhhW7H7UsEf9x8T+ixhiSPObmw/V//xAAlEAEAAQMDAwUBAQAAAAAAAAABEQAhUTFBYRCBkSChscHwcTD/2gAIAQEAAT8hosbS+AKzM28/F3xQK/vp8AWXnqkJCeKIqTEmzhw9UWs04CmSay9fs+KQRrPe+349CyaaMqrjfe3CdHG7vUPtTyO489AWoQg3/E+KgYDDMr1a2WWj0Ni9AuQlGFn6pxz/APi+nipoRURA7Cx7B07LCoo9BxLFjJ4zRQoOQJn+Talug/8AYZ6BA/DDCPMr0ewjWXYU8h1RGN8WJMenV9MoBI3enL41fYFmYF31SK2hk9mXiie4UrT9ixxQaEYt10+hhqCOpTbYg8X9qIeRD+tcJSgtIiK2O4+Ks/1DF4NG8vrsLOTzzTT8pKt1c9HMZYR27zXJYEGm7Bqhe9brJOdr77dLcxjHJzUc0GFGwlfhWwmTc5Xd6lEBS4BzTql+i7d63h0dhl4q/BF93ef8EEhJGklmg0v+v//aAAwDAQACAAMAAAAQ4N8q3ed8BAt+8+CTXt/M888f8//EACERAQABAwUBAAMAAAAAAAAAAAERACExEEFRcYGRIGHR/9oACAEDAQE/EANFdCO1c5C83wbQ85zNPxhLJw1cKGSdIEwA9rSH0KmOxvHJF/RPlMDGaw0ADaZcmBdodqWAm6PI/tGkKizmsTpnEkwxPsUleBgkR3X6UXQ39b/D8FhUHJs96f/EACIRAQABBAEEAwEAAAAAAAAAAAERACExQVEQYXGBILHB8P/aAAgBAgEBPxCMFhl/DvTooCzsu78eM+Oikp5UIJKF+yXy5rKgMdJ3tRTbFSThvkXszf3TTCmlymn+10iipLhUrnEOO0Ez7xVqR1teV2/VNTKk2ZfirQ538EFnp//EACYQAQACAgIBAwQDAQAAAAAAAAERIQAxQVFxEGGBIDCRsaHh8dH/2gAIAQEAAT8Qx2wy/fK4m2R0qc0wbZYAlhlGdYUrovcTwG30ZoiTDb4xAeEthSGw5G/VFySQNKuJ/BoUqvb60KOVYxbFghoxuMGeEHL9CLnFElN0nt+t5WbBazAD0AHZCdplf6w+EuA0+i7Ekuk3/hZkiyU6Ao/E57DHRHEfQhFAG1wBRiFKzfJOffGVbwqAqOoHkmIYoT27THgjBgSHNiEnDJPhHn6EkE/gpU9JrKrH0SNLFSD0KOcWUvhiAD9Z/rZH+EO4obP2McUKQ+SpMHsI6cgniMDNwnEKtk39JWXJhcSS0E4uY16uVrfQgnYJq6PC45ckbkWUMcFUDuN5okKqglcpZQqhwIUJZwqGYTZ6iLLIYmH4yFHKIaQR0peX2ZDGZ9pB/Ln+pijU6JKXLActKZcnyfqkmiUT8bycykLKJYD2AsyqBQu3Uq5a202vpOGoqBAIeJQ8Cc4CD7Dr5HAjxCp+UuIDYFFf9Cf7Mh7fzgTFeR0TgMI8JhkJZQRsSEmwPN430pjvmRadqvqD+xxgYhZCbJ3rDQnVv5H6DFEplPPfgf0XhLzvSF7f0HAB9h2YEIkiZLJBn50ce2re/u//2SAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA=='
$iconBytes = [Convert]::FromBase64String($iconBase64)
# Initialise un flux de mémoire contenant les octets
$stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)

# Trouve LA lettre de la clé USB et prépare le nom et l'emplacement du dossier de copie
$usbletter = get-volume | Where-Object drivetype -eq removable | Select-Object -expandprop driveletter
$destination = $usbletter+":"+$env:USERPROFILE.Substring(8)

# Préparation du fichier de LOG RoboCopy
$log = "robocopy_$env:UserName.log"

<# 
# Création de la variable pour les TreeView (affichage Dossiers et Dossiers cachés)
$childitem = Get-ChildItem -Path $env:USERPROFILE -attributes d | Select-Object -ExpandProperty fullname
$hidden_childitem = Get-ChildItem -Path $env:USERPROFILE -attributes h+d | Select-Object -ExpandProperty fullname
$gci = $childitem + $hidden_childitem
 #>

# Fonction pour la bar de progression

#Liste des Files et des Directories
# $cFiles  = [IO.Directory]::GetFiles('C:\')
$cDirectories = [IO.Directory]::GetDirectories('C:\')

# $userProfileFiles  = [IO.Directory]::GetFiles($env:USERPROFILE)
$userProfileDirectories = [IO.Directory]::GetDirectories($env:USERPROFILE)


# Création de la fenêtre
$choix_form = New-Object System.Windows.Forms.Form
$choix_form.Text = "Sauvegarde et restauration de vos données"
$choix_form.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))
$choix_form.Font = New-Object System.Drawing.Font("Marianne",7,[System.Drawing.FontStyle]::Bold)
$choix_form.AutoSize = $true
$choix_form.StartPosition = "CenterScreen"

$tree = New-Object System.Windows.Forms.TreeView
$tree.Location = New-Object System.Drawing.Point(10, 10)
$tree.Size = New-Object System.Drawing.Size(300, 200)
#$tree.CheckBoxes = $true
#$tree.ExpandAll($true)
$tree.AutoSize = $true
$tree.HotTracking = $true
$choix_form.Controls.Add($tree)

$rootnode = New-Object System.Windows.Forms.TreeNode
$rootnode.text = "Vos Dossiers"
$tree.Nodes.Add($rootnode)

# $dossiers = Get-ChildItem -Path "$env:HOMEDRIVE\"  -attributes d | Select-Object -ExpandProperty fullname
foreach ($dossier in $cDirectories)
{
	if($dossier -eq "C:\Users")
	{
		$subnode = New-Object System.Windows.Forms.TreeNode
		$subnode.text = $dossier

		$rootnode.Nodes.Add($subnode)
		$users = $userProfileDirectories
		foreach ($user in $users)
		{
			$userf = New-Object System.Windows.Forms.TreeNode
			$userf.text = $user
       		$subnode.Nodes.Add($userf)
		}
	}
	else
	{
		$subnode = New-Object System.Windows.Forms.TreeNode
		$subnode.text = $dossier
		$rootnode.Nodes.Add($subnode)
	}
}

$objListBox = New-Object System.Windows.Forms.ListBox 
$objListBox.Location = New-Object System.Drawing.Size(420, 10) 
$objListBox.Size = New-Object System.Drawing.Size(200, 300)
$objListBox.AutoSize = $true
$objListBox.SelectionMode = "MultiExtended"
$choix_form.Controls.Add($objListBox)

# Bouton Ajouter
$Button_ajouter = New-Object System.Windows.Forms.Button
$Button_ajouter.text = "-> Ajouter ->"
$Button_ajouter.Location = New-Object System.Drawing.Size(327, 10)
$Button_ajouter.AutoSize = $true
$choix_form.Controls.Add($Button_ajouter)

# Supprimer
$Button_Supprimer = New-Object System.Windows.Forms.Button
$Button_Supprimer.text = "<- Supprimer <-"
$Button_Supprimer.Location = New-Object System.Drawing.Size(318, 100)
$Button_Supprimer.AutoSize = $true
$choix_form.Controls.Add($Button_Supprimer)

# Bouton Copie
$Button_Copie = New-Object System.Windows.Forms.Button
$Button_Copie.text = "Copie"
$Button_Copie.Location = New-Object System.Drawing.Point(327, 250)
$Button_Copie.AutoSize = $true
$choix_form.Controls.Add($Button_Copie)

# ProgressBar
$progressBar = new-object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point (200, 290)
$progressBar.Size = New-Object System.Drawing.Size(200, 10)
$choix_form.Controls.Add($progressBar)

# Toutcasser
$Button_Toutcasser = new-object System.Windows.Forms.Button
$Button_Toutcasser.Location = New-Object System.Drawing.Point (10, 290)
$Button_Toutcasser.AutoSize = $true
$Button_Toutcasser.Text = "STOPTOU"
$choix_form.Controls.Add($Button_Toutcasser)

$Button_ajouter.Add_click({
	$objListBox.Items.Add($tree.SelectedNode.Text)
})

$Button_Supprimer.Add_click({
	$objListBox.Items.Remove($objListBox.Text)
})

$Button_Toutcasser.Add_click({
	Get-Job -State Running | Stop-Job
})

$Button_Copie.Add_click({

	if((Test-Path "$destination") -ne $true){
		New-Item -ItemType "Directory" -Path "$destination" -Force
	}
	
	$items=$objListBox.Items

	foreach ($item in $items)
	{
<# 		$foldersize = Get-ChildItem -Path $item -Recurse -Force | Measure-Object -property length -sum
		$foldersize = $foldersize.sum / 1MB
		$tailletot = $tailletot + $foldersize
		$progressBar.Maximum = $tailletot #>

		$split=$item.Substring(3)
		if((Test-Path "$destination\$split") -eq $true)
		{
			Start-Job -ScriptBlock{while ((Get-Process -Name "Robocopy") -ne $null){Start-Sleep -Seconds 5}Robocopy.exe $using:item $using:destination\$using:split /tee /XJ /DCOPY:DAT /COPY:DATSOU /MIR /E /MT:4 /Z /R:5 /W:2 /log+:$using:destination\$using:log}

<# 			Start-Sleep -Seconds 5
			$dest = Get-ChildItem $destination -Recurse -Force | Measure-Object -property length -sum
			$dest = $dest.sum / 1MB
			$progressBar.Value = $dest #>
		}
        else
        {
            New-Item -ItemType "Directory" -Path "$destination\$split" -Force
			Start-Job -ScriptBlock{while ((Get-Process -Name "Robocopy") -ne $null){Start-Sleep -Seconds 5}Robocopy.exe $using:item\ $using:destination\$using:split\ /tee /XJ /DCOPY:DAT /COPY:DATSOU /MIR /E /MT:4 /Z /R:5 /W:2 /log+:$using:destination\$using:log}
		}
		
<# 		[System.Windows.MessageBox]::Show($tailletot)
		[System.Windows.MessageBox]::Show($progressBar.Value) #>


		for ($item = 1; $item -le 100; $item++ )
{
Write-Progress -Activity "Avancement de la copie" -Status "$item% copié :" -PercentComplete $item
Start-Sleep -Milliseconds 25
}
		
<# 		$dest = Get-ChildItem $destination -Recurse -Force | Measure-Object -property length -sum
		$dest = $dest.sum / 1MB
		$progressBar.Value = $dest #>

	}
})

for ($i = 0; $i -lt $dossiers.Count; $i++)
{
	if ($rootnode.Nodes[$i].Text -ne "$env:homedrive\Windows" -and $rootnode.Nodes[$i].Text -ne "C:\temp" -and $rootnode.Nodes[$i].Text -ne "C:\users" -and $rootnode.Nodes[$i].Text -ne "C:\Program Files" -and $rootnode.Nodes[$i].Text -ne "C:\Program Files (x86)" -and $rootnode.Nodes[$i].Text -ne "C:\ProgramData" -and $rootnode.Nodes[$i].Text -ne "C:\PerfLogs" -and $rootnode.Nodes[$i].Text -ne "C:\efi" -and $rootnode.Nodes[$i].Text -ne "C:\Cache")
	{
		$objListBox.Items.Add($rootnode.Nodes[$i].Text)
	}
}

<# $dossiers_profile = Get-ChildItem -Path "$env:USERPROFILE\"  -Directory | Select-Object -ExpandProperty fullname
for ($u = 0; $u -lt $dossiers_profile.Count; $u++)
{
	if ($rootnode.Nodes[$u].Text -eq "$dossiers_profile\Desktop")
	{
		$objListBox.Items.Add($rootnode.Nodes[$u].Text)
	}
} #>

# lancelement de la fenêtre
$choix_form.ShowDialog()