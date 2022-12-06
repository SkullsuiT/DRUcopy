## Pour le bon fonctionnement du script, procéder comme suit :


	1-	Garder ce .EXE dans le même dossier que le "Transfert.csv";

	2-	Lancer l'exécutable "Transfert.exe";

	4-	La première fenêtre propose un choix :
>		-	"user backup", est prévu pour sauvegarder un dossier User avec les paramètres défini dans le fichier "Transfert.csv";
>		-	"user restore", transferera les FICHIERS d'un dossier (soit l'user est créer et il faudra pointer dedans ! SOIT l'user n'est pas créer, il faut donc créer un dossier avec son nom_old (par exemple));
>		-	"copy folder", fait comme "user backup" mais sans les paramètres de "Transfert.csv" (une copie de dossier à MACH12 ^^);
>		-	"7-zip", zip un dossier à l'emplacement voulu.


	3-	Si vous faites "user backup", la fenêtre informe du nombre de copies multithread qui seront effectuées
		( exemple : "8" est sélectionné, 8 copie simultannées seront effectuées MAIS si une est un gros .ISO ... les 7 autres seront finies avant, donc les 8 nouvelles commenceront à la fin du transfert du .ISO);
		
		Une dernière fenêtre vous demandera quelle extension de fichier à exlure


	6-	"STOPTOU" est un bouton effectuant un "Stop-Process -Name powershell -Force", donc attention si un autre est en train de travailler ... ça STOPTOU !!!;

	5-	Enjoy !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



## Ce script ne fait pas :
>plein de chose, surout ne pas pointer un lien UNC ):


## Ce script fait :

```shell
/s ; Copie les sous-répertoires. Cette option exclut automatiquement les répertoires vides.
```
```shell
/z ; Copie les fichiers en mode redémarré. En mode redémarré, si une copie de fichier doit être interrompue, Robocopy peut reprendre là où il s’est arrêté au lieu de recopier l’intégralité du fichier.
```
/zb ; Copie les fichiers en mode redémarré. Si l’accès au fichier est refusé, bascule vers le mode de sauvegarde.

/tee ; Écrit la sortie d’état dans la fenêtre de console et dans le fichier journal.

/Eta ; Affiche l’heure estimée de l’arrivée (ETA) des fichiers copiés.

/copyall ; Copie toutes les informations de fichier (Données, Attributs, Horodatages, Liste de contrôle d'accès NTFS (ACL), Informations sur le propriétaire, Information d'audit)

/secfix ; Corrige la sécurité des fichiers sur tous les fichiers, même ignorés.

/timfix ; Corrige les heures de fichier sur tous les fichiers, même ignorés.

/MIR ; Met en miroir une arborescence de répertoires

/MT:8 ; Crée des copies multithread avec n threads.

/Xf ; Exclu les extensions de fichier.

/J ; Copies utilisant des E/S non sauvegardées (recommandées pour les fichiers volumineux).

/r:5 ; Spécifie le nombre de nouvelles tentatives en cas d’échec de la copie.

/w:2 ; Spécifie le délai d’attente entre les tentatives, en secondes.

/Xo ; Les fichiers de répertoire source antérieurs à la destination sont exclus de la copie.

/log ; Écrit la sortie d’état dans le fichier journal (ajoute également la sortie au fichier journal existant dans le %userprofile%).





## 18F Open Source Style Guide


This guide helps people document code repositories so that they're easy to use and understand. In each section, we outline our strategies for making sure that our code repositories are clear, accessible, and user-friendly.

It’s important to make sure our documentation is clear both for internal and external audiences. As our team expands, we want our new employees to easily find and use our existing codebases.

It's also really important if we want to make outside contributors feel welcome or have outside organizations fork and use our code. ([And we do!](https://github.com/18F/open-source-policy/blob/master/policy.md)) Explaining what a project is, why it's important, and how people can help ensures that people can fork and adapt our projects.

(Fork means to copy the code that exists over to your own repo, or repository of code, so that you can adapt or use it as needed.)

This guide also contains a checklist we created that helps ensure our repos are clear, accessible, and user-friendly. Some terminology used may be GitHub-specific, but the concepts are applicable regardless of your version control system or platform. We wrote it so that both non-coders and coders can understand it. (If something is not clear, please let us know.)

We’re sharing it because it we think it’s helpful for lots of organizations, including our own. We know that many of our repos don’t conform to this exact style. By articulating a specific style, we hope this document will also help us improve our own practices.


## How to use this guide

We created this guide for reference on an as-needed basis. It’s here when you’re wondering how to describe a repo, for instance, or when you’re wondering how to create a friendly, informational tone when writing issues for users.

To this end, we’ve structured the guide into descriptively named sections. Browse our table of contents to find the topic you’re looking for.

Most importantly, we encourage you to make a copy of this document and adapt it to your organizational needs. This guide is just that: a guide. It’s not meant to provide the final opinion on any of the topics discussed. If a certain section isn’t relevant to you and your team, delete it. And if you feel the guide is missing a section, by all means, add it by clicking 'edit this page' at the bottom of every page. This guide is yours to use, and we trust you’ll update it in the ways that best suit you.


### Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0
>dedication. By submitting a pull request, you are agreeing to comply
>with this waiver of copyright interest.


### How to run a local copy of this guide

(Instructions adapted from the [18F Documentation Working Group](https://github.com/18F/wg-documentation).)

You will need [Ruby](https://www.ruby-lang.org) ( > version 2.1.5 ). You may
consider using a Ruby version manager such as
[rbenv](https://github.com/sstephenson/rbenv) or [rvm](https://rvm.io/) to
help ensure that Ruby version upgrades don't mean all your
[gems](https://rubygems.org/) will need to be rebuilt.

On OS X, you can use [Homebrew](http://brew.sh/) to install Ruby in
`/usr/local/bin`, which may require you to update your `$PATH` environment
variable:

```shell
$ brew update
$ brew install ruby
```

To serve the site locally:

```shell
$ git clone git@github.com:18F/open-source-guide.git
$ cd open-source-guide
$ ./go serve
```

This will check that your Ruby version is supported, install the [Bundler
gem](http://bundler.io/) if it is not yet installed, install all the gems
needed by the template, and launch a running instance on
`http://localhost:4000/`. (Make sure to include the trailing
slash! The built-in Jekyll webserver doesn't redirect to it.)

After going through these steps, run `./go` to see a list of available
commands. The `serve` command is the most common for routine development.


### How to create your own guide

This guide is based on the [DOCter template](https://github.com/cfpb/DOCter) created by the
[Consumer Financial Protection Bureau](http://www.consumerfinance.gov/) (CFPB). Our canonical
adaptation of DOCter is contained in the [18F Guides Template](https://pages.18f.gov/guides-template/).


### Contact us

If you'd like to contact us, please create a GitHub issue or email 18F@gsa.gov. Thank you!
