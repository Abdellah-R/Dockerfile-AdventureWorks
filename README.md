
#  Dockerfile pour Adventure Works

## Description

Ce guide vous montrera comment utiliser le Dockerfile fourni pour créer un conteneur contenant les bases de données Adventure Works, et comment vous connecter à ces bases de données à l'aide d'Azure Data Studio pour visualiser les diagrammes et exécuter des requêtes.

## Prérequis

- Assurez-vous d'avoir Docker installé sur votre machine avant de commencer.

- Installez Azure Data Studio (ou un autre logiciel tel que Dbeaver).


## Utilisation en local
Etape 1 - Configuration :

- Récupérez le fichier Dockerfile et placez-le dans un dossier sur votre machine.

- Placez les fichiers de sauvegarde AdventureWorks2019.bak et AdventureWorksDW2019.bak dans le même dossier que le Dockerfile.

- Ouvrez votre terminal à la racine du dossier où se trouve le dockerfile et les fichiers .bak pour construire l'image avec cette commande :
```bash
  docker build adventureworks2019_full .
```

- Puis démarrer le conteneur (bien sûr, en pratique on n'affiche pas le mot de passe en dur dans le terminal mais ici c'est juste un exercice) :
```bash
  docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrongPassword123" -p 1433:1433 -d adventureworks2019_full
```

- Vérifier que le conteneur en utilisant l'extension Docker dans VScode ou bien directement avec la commande 
```bash
  docker ps
```


Etape 2 - Connection à Azure Data Studio: 

- Ouvrez Azure Data Studio puis cliquez sur Nouvelle Connection 

- Entrez les informations de connexion comme suit :
  ```bash
    Server Name (Nom du serveur) : localhost \
    Authentication Type (Type d'authentification) : SQL Login \
    Username (Nom d'utilisateur) : sa \
    Password (Mot de passe) : ThisIsAReallyCoolPassword123
  ```
  ![](screenshots/login.png)
  Si vous obtenez un message d'erreur, cliquez sur Enable 

- Vous devriez voir l'écran d'accueil du serveur qui indique qu'il fonctionne sous Linux et que le nom d'hôte est correctement défini.
   [](screenshots/home.png)

- Enfin, vous pouvez faire des requêtes en ouvrant un éditeur SQL : 
  ![](screenshots/query.png)

- Vous pouvez également visualiser le diagramme EER :
  ![](screenshots/diagramme.png)

