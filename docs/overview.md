# Infrastructure Overview

This repository documents my personal sysadmin stack, managed primarily through Dockploy.
Backups are pushed to a Hetzner S3 (Frankfurt) storage box.
Instances are split across **3 primary servers**:

* **Admin Panel (Hetzner VPS, US):** Beszel, Uptime Kuma, OwlBank, Zephira.uk Portfolio
* **Oracle Free Tier (US):** UmberWood, FoundryVTT, Karakeep
* **Oracle Free Tier (AU):** Calibre

---

## Services

### 🌐 Zephira.uk Portfolio

* **Description:** Personal portfolio static site.
* **Repository:** [services/zephislibrary](https://github.com/Zephira58/sysadmin/tree/main/services/zephislibrary)
* **Deployment:** Static HTML/CSS/JS (served via Dockploy & Nginx)
* **Domain:** [https://zephira.uk](https://zephira.uk/)
* **Server:** Hetzner Admin Panel (US)
* **Notes:** No backend required, purely static site. Reverse-proxied through Traefik.

---

### 🎲 FoundryVTT

* **Description:** A self-hosted virtual tabletop for Dungeons & Dragons campaigns.
* **Image:** `felddy/foundryvtt:13`
* **Depends on:** Docker, persistent volume (`foundry-data`)
* **Ports:** `30000:30000`
* **Environment:**

  * `FOUNDRY_USERNAME`
  * `FOUNDRY_PASSWORD`
  * `FOUNDRY_ADMIN_KEY`
* **Server:** Oracle Free Tier (US)
* **Notes:** World data lives in `foundry-data` volume.

---

### 🖥️ Beszel

* **Description:** Hardware monitoring dashboard.
* **Image:** `henrygd/beszel:latest`
* **Ports:** `8090:8090`
* **Volumes:**

  * `beszel_data` (persistent data)
  * `./beszel_socket` (local socket)
* **Server:** Hetzner Admin Panel (US)
* **Notes:** Dashboards/alerts configured for infra.

---

### 📚 Calibre

* **Description:** Web-based ebook manager (Calibre Web).
* **Image:** `lscr.io/linuxserver/calibre-web:latest`
* **Ports:** `8083:8083`
* **Volumes:**

  * `calibre-books` → stores book library
  * `calibre-data` → app config
* **Server:** Oracle Free Tier (AU)
* **Environment:**

  * `PUID`, `PGID`, `TZ`
* **Notes:** Library backed up to Hetzner S3.

---

### 🗂️ Karakeep

* **Description:** Self-hosted note-taking and knowledge base tool.
* **Image:** Github container registry
* **Ports:** 3000
* **Volumes:** Persistent data volume (`karakeep-data`, 'meilisearch-data')
* **Server:** Oracle Free Tier (US)
* **Notes:** Monitored by Uptime Kuma and Beszel for uptime and resource usage.

---

### 📡 Uptime Kuma

* **Description:** Networking uptime/status monitor.
* **Image:** `louislam/uptime-kuma:latest`
* **Ports:** (default internal port, reverse proxy handled)
* **Volumes:** `uptime-kuma-data`
* **Server:** Hetzner Admin Panel (US)
* **Notes:** Tracks uptime of all external-facing services. Alerts to Discord

---

### 🐦 UmberWood

* **Description:** Discord bot + databases for the UmberWood project.
* **Image:** `ghcr.io/rhomelab/red-discordbot:latest`
* **Environment:**

  * `TOKEN`
  * `INSTANCE_NAME=umberwood`
  * `PREFIX=uw:`
  * `TEAM_MEMBERS_ARE_OWNERS=TRUE`
* **Volumes:** `umberwood-data` (persistent bot data)
* **Server:** Oracle Free Tier (US)
* **Notes:** Bot data stored in mounted volume, backups weekly.

---

### 🏦 OwlBank

* **Description:** Mock banking service for the "Go Skate" project.
* **Image:** `dumbwareio/dumbbudget:latest`
* **Ports:** `3862:3000`
* **Volumes:** `owlbank-data`
* **Environment:**

  * `DUMBBUDGET_PIN`
  * `DUMBBUDGET_BASE_URL`
  * `DUMBBUDGET_CURRENCY`
  * `DUMBBUDGET_SITE_TITLE`
  * `DUMBBUDGET_INSTANCE_NAME`
* **Server:** Hetzner Admin Panel (US)

### 💳 ezbookkeeping

* **Description:** A simple accounting software i use for my streaming/freelance stuff
* **Image:** `docker.io/ezbookkeeping`
* **Ports:** `80:80` and `3306:3306`
* **Volumes:** `ezbookkeeping-data` and `ezbookkeeping-db`
    * **Environment:**
      * `MYSQL_ROOT_PASSWORD`
      * `MYSQL_DATABASE`
      * `MYSQL_USER`
      * `MYSQL_PASSWORD`
      * `EBK_SERVER_DOMAIN`
      * `EBK_SERVER_ENABLE_GZIP`
      * `EBK_DATABASE_TYPE`
      * `EBK_DATABASE_HOST`
      * `EBK_DATABASE_NAME`
      * `EBK_DATABASE_USER`
      * `EBK_DATABASE_PASSWD`
      * `EBK_LOG_MODE`
      * `EBK_SECURITY_SECRET_KEY`
* **Server:** Hetzner Admin Panel (US)