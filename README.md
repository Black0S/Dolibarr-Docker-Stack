# Dolibarr Docker Stack

Cette stack Docker permet de déployer **Dolibarr** avec une configuration flexible multi-PHP, multi-serveur (Nginx ou Apache) et Traefik comme reverse proxy HTTPS.

## 🔹 Lancer Dolibarr avec Docker Compose

| Profil                         | traefik | db  | php-fpm | web-nginx | web-apache | phpmyadmin |
|--------------------------------|:-------:|:---:|:-------:|:---------:|:----------:|:----------:|
| Apache sans phpMyAdmin         | ✅      | ✅  | ❌      | ❌        | ✅         | ❌         |
| Apache avec phpMyAdmin         | ✅      | ✅  | ❌      | ❌        | ✅         | ✅         |
| Nginx sans phpMyAdmin          | ✅      | ✅  | ✅      | ✅        | ❌         | ❌         |
| Nginx avec phpMyAdmin          | ✅      | ✅  | ✅      | ✅        | ❌         | ✅         |

✅ Légende :  
- ✅ Service actif  
- ❌ Service non créé

## 🔹 Avantages de la stack Docker

| Catégorie                  | Description / Avantages                                                                                 |
|-----------------------------|--------------------------------------------------------------------------------------------------------|
| **Architecture CPU**        | Choix entre `amd64` (x86/Intel/Windows) et `arm64` (Apple Silicon M1/M2). Compatible multi-plateformes.|
| **Base de données**         | MariaDB ou MySQL, version configurable via `.env`. Permet d’adapter selon compatibilité et performance.|
| **Paramétrage**             | Variables d’environnement centralisées dans `.env`. Facile à modifier pour ports, utilisateurs, mots de passe et images. |
| **Versions PHP**            | Support des versions PHP 7.4, 8.2 et 8.4. Choix entre Apache intégré ou Nginx + PHP-FPM pour flexibilité. |
| **Traefik & HTTPS**         | Reverse proxy automatique avec gestion de certificats Let’s Encrypt, redirection HTTP → HTTPS, HTTP/2. |
| **phpMyAdmin (optionnel)**  | Profil activable pour une gestion simple de la base de données, sans impacter le reste de la stack.    |
| **Multi-profil Docker**     | Possibilité de lancer uniquement les services nécessaires : Nginx ou Apache, avec ou sans phpMyAdmin.  |
| **Sécurité & Performances** | OPCache activé sur toutes les versions PHP, headers de sécurité Nginx configurés, compression Gzip activée. |

⚠️ **IMAP is disabled by default** to prevent crashes in Dolibarr.

---

1️⃣ Apache sans phpMyAdmin**  
```bash
docker-compose --profile apache up -d
```
2️⃣ Apache avec phpMyAdmin
```bash
docker-compose --profile apache --profile phpmyadmin up -d
```
3️⃣ Nginx sans phpMyAdmin
```bash
docker-compose --profile nginx up -d
```
4️⃣ Nginx avec phpMyAdmin
```bash
docker-compose --profile nginx --profile phpmyadmin up -d
```
❌ Arrêter tous les services
```bash
docker-compose down
```

## 🔹 Comparatif technique visuel

| Catégorie             | Option         | Avantages clés                                   | Inconvénients clés                               |
|----------------------|----------------|-------------------------------------------------|-------------------------------------------------|
| **Serveur Web**       | Nginx          | ✅ Haute performance<br>✅ Faible consommation mémoire<br>✅ Compatible PHP-FPM | ⚠ Pas de support `.htaccess`<br>⚠ Config globale requise |
|                       | Apache         | ✅ Très compatible projets<br>✅ Support `.htaccess` | ⚠ Consommation mémoire plus élevée<br>⚠ Moins performant sous forte charge |
| **Base de données**   | MariaDB        | ✅ Rapide et léger<br>✅ Compatible MySQL<br>✅ Communauté active | ⚠ Moins de support commercial officiel |
|                       | MySQL          | ✅ Support commercial<br>✅ Large compatibilité outils | ⚠ Versions lourdes<br>⚠ Licence stricte pour usage commercial |
| **PHP**               | 7.4            | ✅ Stable<br>✅ Compatible anciens projets<br>✅ Faible consommation | ⚠ Fin de support prochainement<br>⚠ Peu de nouvelles fonctionnalités |
|                       | 8.2            | ✅ Performance et sécurité améliorées<br>✅ Syntaxe moderne | ⚠ Risque d’incompatibilité avec anciens scripts |
|                       | 8.4            | ✅ Dernière version stable<br>✅ Meilleures performances | ⚠ Compatibilité avec anciens projets pas garantie |
| **Cache PHP**         | OPcache        | ✅ Accélère exécution PHP<br>✅ Réduit charge CPU | ⚠ Nécessite réglage et supervision<br>⚠ Purge après mise à jour du code |

---

## 🔹 Architecture de la stack

- **Reverse Proxy** : [Traefik](https://traefik.io/) pour HTTPS, redirection HTTP → HTTPS et gestion automatique des certificats Let's Encrypt.
- **Serveur Web** :
  - Nginx + PHP-FPM
  - Apache + PHP intégré
- **PHP** : versions 7.4, 8.2, 8.4 (Apache et FPM)
- **Base de données** : MariaDB ou MySQL (configurable via `.env`)
- **phpMyAdmin** : optionnel, profil activable pour la gestion de la base

## 🔹 Contenus du dépôt

- `docker-compose.yaml` : orchestration des services Docker  
- `.env` : variables d'environnement  
- `nginx/default.conf` : configuration Nginx sécurisée et optimisée pour Dolibarr  
- Dockerfiles :
  - `php-7.4.Dockerfile` et `php-7.4-fpm.Dockerfile`
  - `php-8.2.Dockerfile` et `php-8.2-fpm.Dockerfile`
  - `php-8.4.Dockerfile` et `php-8.4-fpm.Dockerfile`

## 🔹 Pré-requis

- Docker 20.10+  
- Docker Compose 2.0+

## 🔹 Configuration

1. Ouvrir `.env` et ajuster les valeurs selon vos besoins :

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
```

---

## 🔹 Clients externes pour la gestion de la base de données

Si vous préférez utiliser un client externe plutôt que phpMyAdmin, voici nos recommandations :

- **Windows** :  
  - [HeidiSQL](https://www.heidisql.com/) – gratuit, léger et efficace  
  - [DBeaver](https://dbeaver.io/) – gratuit, multi-plateforme et puissant  

- **macOS (Apple Silicon)** :  
  - [Sequel Ace](https://apps.apple.com/fr/app/sequel-ace/id1518036000?mt=12) – gratuit, léger et performant

---
<table width="100%"> <thead> <tr> <th align="left">Catégorie</th> <th align="left">Description / Avantages</th> </tr> </thead> <tbody> <tr> <td><strong>Architecture CPU</strong></td> <td>Choix entre <code>amd64</code> (x86/Intel/Windows) et <code>arm64</code> (Apple Silicon M1/M2). Permet de cibler différentes plateformes et optimise la compatibilité/performance.</td> </tr> <tr> <td><strong>Base de données</strong></td> <td>MariaDB ou MySQL — version configurable via <code>.env</code>. Choix selon compatibilité applicative, performances et support souhaité.</td> </tr> <tr> <td><strong>Paramétrage</strong></td> <td>Variables centralisées dans <code>.env</code> : ports, identifiants, images, versions. Modification rapide sans toucher aux fichiers Compose.</td> </tr> <tr> <td><strong>Versions PHP</strong></td> <td>Support PHP 7.4 / 8.2 / 8.4 ; possibilité d'utiliser Apache (PHP intégré) ou Nginx + PHP-FPM pour chaque version.</td> </tr> <tr> <td><strong>Traefik &amp; HTTPS</strong></td> <td>Reverse proxy automatique avec Let's Encrypt, redirection HTTP → HTTPS et HTTP/2 ready.</td> </tr> <tr> <td><strong>phpMyAdmin (optionnel)</strong></td> <td>Profil activable pour administration rapide de la base sans toucher au reste de la stack.</td> </tr> <tr> <td><strong>Multi-profil Docker</strong></td> <td>Lancez uniquement les services nécessaires (gain de ressources & simplicité pour dev/test/production).</td> </tr> <tr> <td><strong>Sécurité &amp; perf.</strong></td> <td>OPCache activé par défaut, headers de sécurité Nginx préconfigurés, compression gzip active pour assets statiques.</td> </tr> </tbody> </table>
