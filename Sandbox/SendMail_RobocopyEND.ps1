$PSEmailServer = "smtp.ac-nancy-metz.fr"
$MailFrom = "jean-francois.da-silva@ac-nancy-metz.fr"
$MailTo = "jean-francois.da-silva@ac-nancy-metz.fr"
[string[]]$SplitMailTo = $MailTo.Split(',')

$BackupEND = Send-MailMessage -From $MailFrom -To $SplitMailTo -Subject "Sauvegarde finie, $env:COMPUTERNAME, $env:USERNAME" -Body "Écrire les résultats du LOG ?" -BodyAsHtml
$RestoreEND = Send-MailMessage -From $MailFrom -To $SplitMailTo -Subject "Restoration finie, $env:COMPUTERNAME, $env:USERNAME" -Body "Écrire les résultats du LOG ?" -BodyAsHtml