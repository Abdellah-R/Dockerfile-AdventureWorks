
#  Dockerfile pour Adventure Works

## Description

Ce guide vous montrera comment utiliser le Dockerfile fourni pour créer un conteneur contenant les bases de données Adventure Works, et comment vous connecter à ces bases de données à l'aide d'Azure Data Studio pour visualiser les diagrammes et exécuter des requêtes.

## Prérequis

- Assurez-vous d'avoir Docker installé sur votre machine avant de commencer.

- Installez Azure Data Studio (ou un autre logiciel tel que Dbeaver).


## Badges

![Dockerfile](https://img.shields.io/badge/Dockerfile-Exists-brightgreen)


## Utilisation en local

### Etape 1 - Configuration :

- Récupérez le fichier Dockerfile et placez-le dans un dossier sur votre machine.

- Placez les fichiers de sauvegarde AdventureWorks2019.bak et AdventureWorksDW2019.bak dans le même dossier que le Dockerfile.

- Ouvrez votre terminal à la racine du dossier où se trouve le dockerfile et les fichiers .bak pour construire l'image avec cette commande :
```bash
  docker build -t adventureworks2019_full .
```

- Puis démarrer le conteneur en vérifiant que le port 1435 est libre (bien sûr, en pratique on n'affiche pas le mot de passe en dur dans le terminal mais ici c'est juste un exercice) :
```bash
  docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrongPassword123" -p 1435:1433 -d adventureworks2019_full
```

- Vérifier que le conteneur s'est bien exécuter en utilisant l'extension Docker dans VScode ou bien directement avec la commande 
```bash
  docker ps
```


### Etape 2 - Connection à Azure Data Studio: 

- Ouvrez Azure Data Studio puis cliquez sur Nouvelle Connection 

- Entrez les informations de connexion comme suit :
  ```bash
    Server Name (Nom du serveur) : localhost,1435 \
    Authentication Type (Type d'authentification) : SQL Login \
    Username (Nom d'utilisateur) : sa \
    Password (Mot de passe) : ThisIsAReallyCoolPassword123
  ```
  ![](screenshots/login)
  
Si vous obtenez un message d'erreur, cliquez sur Enable 

- Vous devriez voir l'écran d'accueil du serveur qui indique qu'il fonctionne sous Linux et que le nom d'hôte est correctement défini.
  ![](screenshots/home)

- Enfin, vous pouvez faire des requêtes en ouvrant un éditeur SQL : 
  ![](screenshots/query)

- Vous pouvez également visualiser le diagramme EER :
  ![](screenshots/diagramme)

## Ressources

- [**Fichiers de Sauvegarde AdventureWorks**](https://learn.microsoft.com/fr-fr/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)
  
- [**Exercices SQL avec AdventureWorks**](https://www.w3resource.com/sql-exercises/adventureworks/adventureworks-exercises.php#SQLEDITOR)

- [**Documentation sur SQL**](https://sqlbolt.com/lesson/introduction)

- [**Installation de Docker**](https://docs.docker.com/engine/install/ubuntu/)

- [**Installation d'Azure Data Studio**](https://learn.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver16&tabs=redhat-install%2Credhat-uninstall)