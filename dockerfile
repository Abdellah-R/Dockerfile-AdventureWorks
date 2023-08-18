# Utiliser l'image SQL Server de votre choix en fonction de vos besoins
FROM mcr.microsoft.com/mssql/server:latest

# Note: Ceci n'est pas un mot de passe sécurisé, ne l'utilisez pas en production.
ENV SA_PASSWORD=ThisIsAReallyCoolPassword123
ENV ACCEPT_EULA=Y

# Définir l'utilisateur 
USER mssql

# Copier les fichiers de sauvegarde dans le répertoire /var/opt/mssql/backup/ du conteneur
COPY AdventureWorks2019.bak /var/opt/mssql/backup/
COPY AdventureWorksDW2019.bak /var/opt/mssql/backup/

# Lancer SQL Server, attendre que le démarrage soit terminé, puis restaurer les bases de données
RUN ( /opt/mssql/bin/sqlservr & ) | grep -q "Service Broker manager has started" \
    && /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q 'RESTORE DATABASE AdventureWorks2019 FROM DISK = "/var/opt/mssql/backup/AdventureWorks2019.bak" WITH MOVE "AdventureWorks2019" TO "/var/opt/mssql/data/AdventureWorks2019.mdf", MOVE "AdventureWorks2019_log" TO "/var/opt/mssql/data/AdventureWorks2019_log.ldf", NOUNLOAD, STATS = 5' \
    && /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q 'RESTORE DATABASE AdventureWorksDW2019 FROM DISK = "/var/opt/mssql/backup/AdventureWorksDW2019.bak" WITH MOVE "AdventureWorksDW2017" TO "/var/opt/mssql/data/AdventureWorksDW2019.mdf", MOVE "AdventureWorksDW2017_log" TO "/var/opt/mssql/data/AdventureWorksDW2019_log.ldf", NOUNLOAD, STATS = 5' \
    && pkill sqlservr

# Définir la commande par défaut pour exécuter SQL Server
CMD ["/opt/mssql/bin/sqlservr"]