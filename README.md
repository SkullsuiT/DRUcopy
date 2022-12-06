## Pour le bon fonctionnement du script :


1-	Garder l'éxécutable dans le même dossier que le "Transfert.csv";

2-	Lancer l'exécutable "Transfert.exe";

3-	La première fenêtre propose un choix :
>-	"`user backup`", est prévu pour sauvegarder un dossier User avec les paramètres défini dans le fichier "Transfert.csv";
>-	"`user restore`", transferera les FICHIERS d'un dossier (soit l'user est créer et il faudra pointer dedans ! SOIT l'user n'est pas créer, il faut donc créer un dossier avec son nom_old (par exemple));
>-	"`copy folder`", fait comme "user backup" mais sans les paramètres de "Transfert.csv" (une copie de dossier à MACH12 ^^);
>-	"`7-zip`", zip un dossier à l'emplacement voulu.


4-	Si vous faites "user backup":
>- la fenêtre propose de choisir le nombre de copies multithread qui seront effectuées ("8" est sélectionné, 8 copie simultannées seront effectuées MAIS si une est un gros .ISO ... les 7 autres seront finies avant, donc les 8 nouvelles commenceront à la fin du transfert du .ISO);
>- Une dernière fenêtre vous demandera quelle extension de fichier à exlure;

5-	"`STOPTOU`" est un bouton effectuant
```powershell
Stop-Process -Name powershell -Force # Si un autre processus PowerShell est en train de travailler ... ça STOPTOU !!!
```
6-	Enjoy !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



## Ce script ne fait pas :

Malhereusement plein de chose, surout ne pas pointer un lien `UNC`.

## Ce script fait :

1-	Un `user backup`, pour sauvegarder l'user local en respectant le fichier `Transfert.csv`;
2-	Un `user restore`, pour restaurer un user (ne copie pas le dossier source, seulement son contenue);
3-	Un `copy folder`, simple copie de fichier améliorée par RoboCopy;
4-	Un `7-zip`, zip simplement un dossier vers une source. À terme zippera un utilisateur avec la méthode du `user backup`.


## Les options de RoboCopy :


`/s` ; Copie les sous-répertoires. Cette option exclut automatiquement les répertoires vides.

`/z` ; Copie les fichiers en mode redémarré. En mode redémarré, si une copie de fichier doit être interrompue, Robocopy peut reprendre là où il s’est arrêté au lieu de recopier l’intégralité du fichier.

`/zb` ; Copie les fichiers en mode redémarré. Si l’accès au fichier est refusé, bascule vers le mode de sauvegarde.

`/tee` ; Écrit la sortie d’état dans la fenêtre de console et dans le fichier journal.

`/Eta` ; Affiche l’heure estimée de l’arrivée (ETA) des fichiers copiés.

`/copyall` ; Copie toutes les informations de fichier (Données, Attributs, Horodatages, Liste de contrôle d'accès NTFS (ACL), Informations sur le propriétaire, Information d'audit)

`/secfix` ; Corrige la sécurité des fichiers sur tous les fichiers, même ignorés.

`/timfix` ; Corrige les heures de fichier sur tous les fichiers, même ignorés.

`/MIR` ; Met en miroir une arborescence de répertoires

`/MT:8` ; Crée des copies multithread avec n threads.

`/Xf` ; Exclu les extensions de fichier.

`/J` ; Copies utilisant des E/S non sauvegardées (recommandées pour les fichiers volumineux).

`/r:5` ; Spécifie le nombre de nouvelles tentatives en cas d’échec de la copie.

`/w:2` ; Spécifie le délai d’attente entre les tentatives, en secondes.

`/Xo` ; Les fichiers de répertoire source antérieurs à la destination sont exclus de la copie.

`/log` ; Écrit la sortie d’état dans le fichier journal (ajoute également la sortie au fichier journal existant dans le %userprofile%).