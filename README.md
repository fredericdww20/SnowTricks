# Snowboard Tricks Community Site

## Contexte

Jimmy Sweat est un entrepreneur ambitieux passionné de snowboard. Son objectif est de créer un site collaboratif pour faire connaître ce sport auprès du grand public et aider à l'apprentissage des figures (tricks).

Il souhaite capitaliser sur du contenu apporté par les internautes afin de développer un contenu riche et suscitant l’intérêt des utilisateurs du site. Par la suite, Jimmy souhaite développer un business de mise en relation avec les marques de snowboard grâce au trafic que le contenu aura généré.

## Mission

Votre mission est de créer un site communautaire pour apprendre les figures de snowboard, en répondant aux besoins suivants :

- Un annuaire des figures de snowboard (10 figures initiales)
- Gestion des figures (création, modification, consultation)
- Un espace de discussion commun pour chaque figure

## Fonctionnalités

- Page d'accueil avec la liste des figures
- Page de création d'une nouvelle figure
- Page de modification d'une figure
- Page de présentation d'une figure avec un espace de discussion

## Prérequis

- PHP >= 7.4
- Composer
- Symfony CLI
- Node.js avec npm ou yarn
- Base de données MySQL

## Installation

1. Cloner le repository :
   ```bash
   git clone https://github.com/username/nom_du_repo.git
   cd nom_du_repo

2. Installer les dépendances PHP avec Composer :
    ```bash
    composer install

3. Installer les dépendances JavaScript :
   ```bash
    npm install

4. Configurer la base de données dans le fichier .env :
   ```bash
   DATABASE_URL="mysql://db_user:db_password@127.0.0.1:3306/db_name"

5. Initialiser la base de données et charger les données initiales :
   ```bash
   php bin/console doctrine:database:create
   php bin/console doctrine:schema:update --force
   php bin/console doctrine:fixtures:load

6. Lancer le serveur de développement :
   ```bash
   symfony serve

7. Accéder à l'application dans votre navigateur :
   ```bash
   http://localhost:8000

Diagrammes
Les diagrammes UML (modèle de données, classes, séquences, use cases) sont disponibles dans le dossier diagrammes.
