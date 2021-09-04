# LOG710 - Laboratoire 1

Ce projet contient le code source du laboratoire 1 du cours LOG710.

## Dépendances

Les dépendances externes suivantes sont nécessaire sur Ubuntu pour compiler et
utiliser ce projet:

  - build-essential
  - pkg-config
  - libreadline-dev

Ces dernières sont disponibles par défaut sur la machine virtuelle qui vous est
fournie ou sont installable par cette commande sur Ubuntu:

```
$ sudo apt install build-essential pkg-config libreadline-dev
```

## Construction

Afin de construire les exécutables dans le cadre de ce laboratoire, il ne
suffit que d'utiliser cette commande à la racine du code du laboratoire
(celui contenant le fichier *Makefile*):

```sh
$ make
```

Deux exécutables sont généré respectivement pour la partie 1, ainsi que la
partie 2 et la partie 3:

  - RunCmd
  - Log710Shell

## Outils intéressants

### *valgrind*

*valgrind* est un programme pour Linux permettant de valider l'exécution d'un
programme.  *valgrind* est votre ami pour valider la qualité de votre
implémentation du laboratoire, et il vous est fortement recommandé de souvent
exécuter votre code sous ce dernier:

```sh
$ valgrind --leak-check=full ./RunCmd [...]
```

*valgrind* vous aidera à trouver des problèmes tels:

  - Fuites de mémoire;
  - Double libération de mémoire;
  - Lecture de mémoire non-initialisée;
  - Lecture ou écrire de mémoire invalide;
  - Exécution de comportement non-définit;
  - etc.

Comme tout programme Linux, la documentation est disponible avec `man valgrind`.

### *strace*

*strace* est une programme interceptant et affichant les appels système d'un
programme.  Ce dernier affiche le nom de l'appel système, les arguments de
l'appel système, ainsi que le code de retour (et l'erreur si nécessaire):

```sh
$ strace ./RunCmd [...]
```

Comme tout programme Linux, la documentation est disponible avec `man strace`.

## Problèmes

### Git - Detected Dubious Ownership

Ce problème survient lorsque le dossier dans lequel vous travailler avec Git
n'appartient pas à votre utilisateur.  Cela risque de survenir avec des dossiers
partagées, car ces derniers appartiennent à `root:vboxsf`.  Votre utilisateur
fait parti du groupe `vboxsf`, et peut donc lire, modifier et exécuter, mais Git
ne comprend pas cela.  Utilisez la commande suivante afin de désactiver cette
fonctionnalitée de Git:

```sh
$ git config --global --add safe.directory '*'
```

### Git - Old Mode et New Mode dans le Diff

Par défaut, Git sauvegarde aussi les permissions des fichiers et dossiers du
projet, cependant les permissions de vos fichiers et dossiers peuvent grandement
changer entre votre machine hôte et votre machine invitée.

```
diff --git a/.editorconfig b/.editorconfig
old mode 100644
new mode 100755
```

Pour empêcher Git de prendre en compte les permissions de fichiers et dossiers,
assurez vous que le fichier `.git/config` ne comporte pas d'option
`core.filemode`, et exécutez cette commande:

```sh
$ git config --global core.filemode false
```
