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
