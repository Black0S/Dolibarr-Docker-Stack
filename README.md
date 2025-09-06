## 🔹 Lancer Dolibarr avec Docker Compose

### Services par profil

| Profil                         | traefik | db  | php-fpm | web-nginx | web-apache | phpmyadmin |
|--------------------------------|:-------:|:---:|:-------:|:---------:|:----------:|:----------:|
| Apache sans phpMyAdmin          | ✅      | ✅  | ❌      | ❌        | ✅         | ❌         |
| Apache avec phpMyAdmin          | ✅      | ✅  | ❌      | ❌        | ✅         | ✅         |
| Nginx sans phpMyAdmin           | ✅      | ✅  | ✅      | ✅        | ❌         | ❌         |
| Nginx avec phpMyAdmin           | ✅      | ✅  | ✅      | ✅        | ❌         | ✅         |

✅ Légende :  
- ✅ Service actif  
- ❌ Service non créé  

---

### Commandes Docker Compose

1️⃣ Apache sans phpMyAdmin
```bash
docker-compose --profile apache up -d

2️⃣ Apache avec phpMyAdmin
```bash
docker-compose --profile apache --profile phpmyadmin up -d

3️⃣ Nginx sans phpMyAdmin
docker-compose --profile nginx up -d

4️⃣ Nginx avec phpMyAdmin
docker-compose --profile nginx --profile phpmyadmin up -d

Arrêter tous les services
docker-compose down

# Dolibarr Docker Stack

Cette stack Docker permet de déployer **Dolibarr** avec une configuration flexible multi-PHP, multi-serveur (Nginx ou Apache) et Traefik comme reverse proxy HTTPS.

---

## Architecture de la stack

- **Reverse Proxy** : [Traefik](https://traefik.io/) pour HTTPS, redirection HTTP → HTTPS et gestion des certificats Let’s Encrypt.
- **Serveur Web** :
  - Nginx + PHP-FPM
  - Apache + PHP intégré
- **PHP** : versions 7.4, 8.2, 8.4 (Apache et FPM)
- **Base de données** : MariaDB (10.11) ou MySQL (configurable via `.env`)
- **phpMyAdmin** : optionnel, profil activable pour gérer la base de données.

---

## Contenus du repo

- `docker-compose.yml` : orchestration des services Docker
- `.env` : variables d’environnement
- `nginx/default.conf` : configuration Nginx sécurisée et optimisée pour Dolibarr
- Dockerfiles :
  - `php-7.4.Dockerfile` et `php-7.4-fpm.Dockerfile`
  - `php-8.2.Dockerfile` et `php-8.2-fpm.Dockerfile`
  - `php-8.4.Dockerfile` et `php-8.4-fpm.Dockerfile`

---

## Pré-requis

- Docker 20.10+  
- Docker Compose 2.0+  
- Accès réseau pour Traefik (HTTPS, ports 80 et 443)

---

## Configuration

1. Copier `.env.example` en `.env` et modifier les valeurs selon votre environnement :

```env
ARCH=amd64
DB_TYPE=mariadb
DB_IMAGE=mariadb:10.11
DB_ROOT_PASSWORD=rootPASS
DB_DATABASE=dolibarr
DB_USER=dbuser
DB_PASSWORD=dbpass
WEB_SERVER_PORT=80
WEB_SERVER_IMAGE=nginx:1.26.3
PHP_VERSION=8.4
PHPMYADMIN_PORT=8082
PHPMYADMIN_VERSION=5.3.1


┌──────────────┐
│   Traefik    │  Reverse Proxy HTTPS
└─────┬────────┘
      │
      ├───────────────┐
      │               │
  ┌───▼────┐     ┌────▼────┐
  │ Nginx  │     │ Apache  │
  │ +FPM   │     │ +PHP    │
  └───┬────┘     └────┬────┘
      │               │
      │               │
  ┌───▼───────────────▼───┐
  │       PHP-FPM / PHP      │
  └─────────┬───────────────┘
            │
        ┌───▼───┐
        │  DB   │  MariaDB / MySQL
        └───┬───┘
            │
        ┌───▼───┐
        │phpMyAdmin│ (optionnel)
        └─────────┘
