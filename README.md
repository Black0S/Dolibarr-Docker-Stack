# 🚀 Dolibarr Docker Stack

[![Dolibarr](https://img.shields.io/badge/Dolibarr-blue)](https://www.dolibarr.org/) 
[![Docker](https://img.shields.io/badge/Docker-blue)](https://www.docker.com/) 
[![Traefik](https://img.shields.io/badge/Traefik-blue)](https://traefik.io/) 
[![PHP](https://img.shields.io/badge/PHP-8.4_|_8.2|_7.4-blue.svg)](https://www.php.net/) 
[![MariaDB](https://img.shields.io/badge/MariaDB-blue)](https://mariadb.org/) 
[![MySQL](https://img.shields.io/badge/MySQL-blue)](https://www.mysql.com/) 
[![Nginx](https://img.shields.io/badge/Nginx-blue)](https://nginx.org/) 
[![Apache](https://img.shields.io/badge/Apache-blue)](https://httpd.apache.org/) 
[![Caddy](https://img.shields.io/badge/Caddy-blue)](https://caddyserver.com/) 
[![Lighttpd](https://img.shields.io/badge/Lighttpd-blue)](https://www.lighttpd.net/) 
[![phpMyAdmin](https://img.shields.io/badge/phpMyAdmin-blue)](https://www.phpmyadmin.net/)


Un environnement de développement local **complet, flexible et performant** pour **Dolibarr ERP/CRM**, propulsé par Docker et Traefik. Choisissez votre serveur web (Nginx, Apache, Caddy, Lighttpd) et lancez votre stack en une seule commande.

## 📖 Table des matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [📂 Structure du Projet](#-structure-du-projet)
- [🚀 Guide de Démarrage](#-guide-de-démarrage)
  - [Prérequis](#prérequis)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Lancement](#lancement)
- [⚙️ Utilisation](#️-utilisation)
  - [Accès aux services](#accès-aux-services)
  - [Gestion de la stack](#gestion-de-la-stack)
- [⚖️ Comparatif des Serveurs Web & Base de Données](#️-comparatif-des-serveurs-web--base-de-données)
- [🗄️ Gestion de base de données (hors phpMyAdmin)](#️-gestion-de-base-de-données-hors-phpmyadmin)
- [🤝 Contribution](#-contribution)

## ✨ Fonctionnalités

- **Reverse Proxy Automatisé** : Traefik pour une gestion transparente des routes et du HTTPS local.
- **Serveur Web au Choix** : Flexibilité maximale avec les profils Docker Compose : `nginx`, `apache`, `caddy`, et `lighttpd`.
- **PHP-FPM Optimisé** : Services PHP découplés pour des performances accrues avec Nginx, Caddy et Lighttpd.
- **Base de Données Robuste** : MariaDB, la base de données open-source recommandée pour Dolibarr, ou bien MySQL.
- **Gestion de Base de Données** : Accès facile via phpMyAdmin (profil optionnel).
- **Structure Claire et Modulaire** : Organisation logique des fichiers de configuration, des sources et des modules personnalisés.

## 📂 Structure du Projet

```
.
├── dolibarr-core/      # 📚 Sources de Dolibarr (à ajouter manuellement)
├── dolibarr-stack/     # ⚙️ Cœur de la stack (docker-compose.yaml, .env)
├── custom/             # 🧩 Modules Dolibarr personnalisés
├── conf/               # 📄 Fichier conf.php de Dolibarr (généré à l'installation)
├── php-dockerfile/     # 🐳 Dockerfiles pour les images PHP
└── web-server/         # 🌐 Configurations des serveurs web (Nginx, Apache, etc.)
```

## 🚀 Guide de Démarrage

### Prérequis

- [Docker](https://www.docker.com/get-started)

### Installation

1.  Téléchargez la version de Dolibarr que vous souhaitez utiliser depuis le [site officiel](https://www.dolibarr.org/downloads).
2.  Décompressez l'archive et placez le contenu (le dossier `dolibarr-(la version)`) dans le dossier `dolibarr-core/`.

### Configuration

Le fichier `dolibarr-stack/.env` est le centre de votre configuration.

> ⚠️ **IMPORTANT** : Avant de lancer la stack, ouvrez ce fichier et vérifiez que les variables (versions des logiciels, mots de passe, etc.) correspondent à vos besoins.

### Lancement

Placez-vous dans le dossier `dolibarr-stack/` et exécutez l'une des commandes ci-dessous selon votre choix de serveur web.

| Serveur Web | Commande de base                             | Avec phpMyAdmin                                                |
|-------------|----------------------------------------------|----------------------------------------------------------------|
| **Nginx**   | `docker-compose --profile nginx up -d`       | `docker-compose --profile nginx --profile phpmyadmin up -d`    |
| **Apache**  | `docker-compose --profile apache up -d`      | `docker-compose --profile apache --profile phpmyadmin up -d`   |
| **Caddy**   | `docker-compose --profile caddy up -d`       | `docker-compose --profile caddy --profile phpmyadmin up -d`    |
| **Lighttpd**| `docker-compose --profile lighttpd up -d`    | `docker-compose --profile lighttpd --profile phpmyadmin up -d` |

## ⚙️ Utilisation

### Accès aux services

- **Traefik** : [https://localhost:8080](https://localhost:8080)
- **Dolibarr** : [https://localhost](https://localhost)
- **phpMyAdmin** : [https://pma.localhost](https://pma.localhost)

Lors du premier accès à Dolibarr, suivez l'assistant d'installation. Le fichier de configuration `conf.php` sera automatiquement créé dans le dossier `conf/` à la racine du projet.

### Gestion de la stack

- **Arrêter la stack** :
  ```bash
  docker-compose down
  ```
- **Changer de serveur web** :
  - Arrêtez la stack :
    ```bash
    docker-compose down
    ```
  - Relancez avec un nouveau profil
    ```bash
    docker-compose --profile caddy up -d
    ```

## ⚖️ Comparatif des Serveurs Web & Base de Données

| Serveur   | Avantages                                           | Inconvénients                               | Idéal pour...                                         |
|-----------|-----------------------------------------------------|---------------------------------------------|-------------------------------------------------------|
| **Nginx** | Haute performance, faible consommation mémoire      | Pas de `.htaccess`, configuration globale   | Projets à fort trafic, applications modernes          |
| **Apache**| Grande compatibilité, support `.htaccess`           | Plus lourd, moins performant sous charge    | Projets legacy, besoin de flexibilité via `.htaccess` |
| **Caddy** | Configuration simple, HTTPS automatique natif       | Moins répandu, communauté plus petite       | Simplicité et sécurité "out-of-the-box"               |
| **Lighttpd**| Extrêmement léger, très rapide pour les statiques | Moins de fonctionnalités avancées           | Environnements avec très peu de ressources            |

## ⚖️ Comparatif des Bases de Données

| Base           | Avantages                                   | Inconvénients                             |
|----------------|---------------------------------------------|-------------------------------------------|
| **MariaDB**    | Open source, rapide, légère                 | Compatibilité MySQL pas toujours parfaite |
| **MySQL**      | Large communauté, très compatible           | Licence moins libre, un peu plus lourd    |
| **PostgreSQL** | Très robuste, transactions ACID, extensions | Plus complexe pour les débutants          |



## 🗄️ Gestion de base de données (hors phpMyAdmin)

| Application                                                               | OS             | Licence            | Bases compatibles                                            |
|---------------------------------------------------------------------------|----------------|--------------------|--------------------------------------------------------------|
| [HeidiSQL](https://www.heidisql.com/)                                     | Windows        | Gratuit            | MySQL, MariaDB, PostgreSQL, SQL Server                       |
| [DBeaver](https://dbeaver.io/)                                            | Windows, MacOS | Gratuit / Freemium | MySQL, MariaDB, PostgreSQL, Oracle, SQL Server, SQLite, etc. |
| [DbVisualizer](https://www.dbvis.com/)                                    | Windows, MacOS | Freemium           | MySQL, MariaDB, PostgreSQL, Oracle, SQL Server               |
| [Sequel Ace](https://apps.apple.com/fr/app/sequel-ace/id1518036000?mt=12) | MacOS          | Gratuit            | MySQL, MariaDB                                               |


## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une *issue* ou une *pull request* pour proposer des améliorations.
