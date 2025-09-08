# 🚀 Dolibarr Docker Stack

[![Dolibarr](https://img.shields.io/badge/Dolibarr-blue)](https://www.dolibarr.org/) 
[![Docker](https://img.shields.io/badge/Docker-blue)](https://www.docker.com/) 
[![PHP](https://img.shields.io/badge/PHP-8.4_|_8.2_|_7.4-blue)](https://www.php.net/) 
[![Traefik](https://img.shields.io/badge/Traefik-purple)](https://traefik.io/) 
[![phpMyAdmin](https://img.shields.io/badge/phpMyAdmin-purple)](https://www.phpmyadmin.net/) 
[![MariaDB](https://img.shields.io/badge/MariaDB-teal)](https://mariadb.org/) 
[![MySQL](https://img.shields.io/badge/MySQL-teal)](https://www.mysql.com/) 
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-teal)](https://www.postgresql.org/) 
[![Apache](https://img.shields.io/badge/Apache-grey)](https://httpd.apache.org/) 
[![Nginx](https://img.shields.io/badge/Nginx-grey)](https://nginx.org/) 
[![Caddy](https://img.shields.io/badge/Caddy-grey)](https://caddyserver.com/) 
[![Lighttpd](https://img.shields.io/badge/Lighttpd-grey)](https://www.lighttpd.net/)

Un environnement de développement local **complet, flexible et performant** pour **Dolibarr ERP/CRM**, propulsé par Docker et Traefik. Choisissez votre version PHP (8.4, 8.2, 7.4), base de donnée (MariaDB, MySQL, PostgreSQL), serveur web (Nginx, Apache, Caddy, Lighttpd) et lancez votre stack en une seule commande.

## 📖 Table des matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [📂 Structure du Projet](#-structure-du-projet)
- [🚀 Guide de Démarrage](#-guide-de-démarrage)
  - [Prérequis](#prérequis)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Lancement](#lancement)
- [Pas d’installation IMAP](#pas-dinstallation-imap)
  - [Raison](#raison)
  - [À quoi sert IMAP ?](#à-quoi-sert-imap-)
  - [Conséquence](#conséquence)
  - [Évolution](#évolution)
- [⚙️ Utilisation](#⚙️-utilisation)
  - [Accès aux services](#accès-aux-services)
  - [Gestion de la stack](#gestion-de-la-stack)
- [⚖️ Comparatif des Serveurs Web & Base de Données](#⚖️-comparatif-des-serveurs-web--base-de-données)
- [🗄️ Gestion de base de données (hors phpMyAdmin)](#🗄️-gestion-de-base-de-données-hors-phpmyadmin)
- [🤝 Contribution](#🤝-contribution)

## ✨ Fonctionnalités

- **Reverse Proxy Automatisé** : Traefik pour une gestion transparente des routes et du HTTPS local.
- **Serveur Web au Choix** : Flexibilité maximale avec les profils Docker Compose : `nginx`, `apache`, `caddy`, et `lighttpd`.
- **PHP-FPM Optimisé** : Services PHP découplés pour des performances accrues avec Nginx, Caddy et Lighttpd.
- **Base de Données Robuste** : MariaDB, la base de données open-source recommandée pour Dolibarr, MySQL ou bien PostgreSQL.
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

## Pas d’installation IMAP

> 🚨 **Attention** : la bibliothèque **IMAP** n’est **pas installée** dans cette stack Docker.

### Raison
- Les librairies IMAP posent problème avec certaines versions récentes de **PHP** :  
  - Certaines extensions ont été **dépréciées ou supprimées**.  
  - La compatibilité varie selon l’OS (par exemple : disponibles sous Windows, absentes ou instables sous macOS Apple Silicon).  
- Cela entraîne des **bugs à l’installation** et des comportements instables.  

### À quoi sert IMAP ?
- **IMAP (Internet Message Access Protocol)** permet à Dolibarr (et plus largement à PHP) de :  
  - Se connecter directement à une **boîte mail** (Gmail, Exchange, IMAP d’un serveur d’entreprise, etc.).  
  - Lire et traiter les **mails entrants** pour en faire, par exemple, des **tickets** ou des **messages internes**.  
  - Synchroniser les mails sans les supprimer du serveur (contrairement à POP3).  
- Dans Dolibarr, cela peut être utilisé notamment par le **module E-Mail/Support** pour automatiser la récupération des courriels.  

### Conséquence
Par sécurité et pour assurer une compatibilité maximale, **IMAP n'es pas installét** lors de l’installation de cette stack.

### Évolution
Ce choix n’est pas définitif :  
- La situation dépend des futures versions de **PHP** et de la disponibilité des librairies IMAP.  
- Dès que le problème sera **clairement résolu et stabilisé**, la stack sera **mise à jour** afin de réintégrer IMAP proprement.  

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
