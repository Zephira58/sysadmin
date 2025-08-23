# Disaster Recovery Guide

This document explains how to restore services after a server wipe.
Backups are stored in **Hetzner S3 (Frankfurt)**.
Service definitions and deployment configs are stored in this GitHub repo.

---

## 1. Provision Servers

* Oracle Free Tier (US) → FoundryVTT, UmberWood
* Oracle Free Tier (AU) → Calibre, Karakeep
* Hetzner VPS (US) → Admin Panel (Beszel, Uptime Kuma, OwlBank, Portfolio)

Install required software:

```bash
apt update && apt install -y docker docker-compose git
```

---

## 2. Clone Repository

Clone the sysadmin repo onto the new server:

```bash
git clone https://github.com/Zephira58/sysadmin.git /opt/sysadmin
cd /opt/sysadmin/services
```

All deployment files are contained within the repo under `/services/<service-name>`.

---

## 3. Restore Volumes and ENV's

Each service uses **external Docker volumes**. Restore them from S3 backups if data is required:

* `foundry-data`
* `umberwood-data`
* `calibre-books`
* `calibre-data`
* `uptime-kuma-data`
* `beszel_data`
* `owlbank-data`
* `karakeep-data`
* `meilisearch-data`

Environment files are stored in `/opt/sysadmin/env/` after repo clone.
**Note:** The `/env` folder is excluded from GitHub for security — restore it from your secure local backup.

---

## 4. Redeploy Services

### 4a. Manual Deployment

1. Navigate to the service folder:

```bash
cd /opt/sysadmin/services/<service-name>
```

2. Start with Docker Compose:

```bash
docker-compose up -d
```

3. Verify logs:

```bash
docker logs -f <container>
```

### 4b. Dockploy Deployment

Dockploy can redeploy all services directly from the GitHub repo.

---

## 5. Service Notes

* **FoundryVTT:** Requires `FOUNDRY_USERNAME`, `FOUNDRY_PASSWORD`, `FOUNDRY_ADMIN_KEY`. Restore `foundry-data`.
* **Beszel:** Restore `beszel_data` volume.
* **Calibre:** Restore `calibre-books` and `calibre-data`.
* **Uptime Kuma:** Restore `uptime-kuma-data`.
* **UmberWood:** Restore `umberwood-data` and re-inject `TOKEN`.
* **OwlBank:** Restore `owlbank-data` and re-apply environment variables.
* **Karakeep:** Restore `karakeep-data` and `meilisearch-data`. Ensure environment variables are re-applied for authentication and search index.
* **Zephira.uk (Portfolio Website):**

  * Deployment files are under `/services/zephislibrary`.
  * To redeploy latest version:

    ```bash
    git fetch https://github.com/Zephira58/sysadmin.git
    cd /sysadmin/stacks
    docker-compose up -d --build
    ```
  * Ensure Traefik/Cloudflare are correctly routing traffic.
  * SSL handled by Traefik or Cloudflare.

---

## 6. Verification

* Uptime Kuma shows all services green.
* FoundryVTT loads saved campaigns.
* UmberWood bot responds in Discord.
* Calibre web interface shows library.
* OwlBank dashboard is reachable.
* Karakeep UI loads and search is functional (Meilisearch running).
* Beszel metrics streaming from all nodes.
* Zephira.uk loads correctly with valid SSL and updated content.
