$location = Get-Location # Le .CSV doit être dans le même dossier que le .PS1 / le cas échéant, commenter et indiquer le chemin
$CSV = Import-Csv -Path $location -Encoding 'UTF8' -Delimiter ';'

$log = "robocopy_$env:UserName.log"

$Options = "*.* /tee /XJ /DCOPY:DAT /COPY:DATSOU /eta /MIR /MT:4 /R:5 /W:2 /XO /log+:$env:USERPROFILE\$log"

# Lecture du .CSV
foreach ($Line in $CSV) {
        if(Test-Path -path "$($Line.Destination)" -ne $null) # Si le dossier de destination éxiste -> copie
        {
            $cmd = "Robocopy.exe '$($Line.Source)' '$($Line.Destination)' $Options"
            Invoke-Expression $cmd
        }
        else
        {
            New-Item -ItemType "Directory" -Path $($Line.Destination) -Force # Sinon, création de celui-ci + copie
            $cmd = "Robocopy.exe '$($Line.Source)' '$($Line.Destination)' $Options"
            Invoke-Expression $cmd
        }
    }
