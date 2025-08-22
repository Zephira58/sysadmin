# Infrastructure Overview

This repository documents my personal sysadmin stack, managed primarily through Dockploy.
Backups are pushed to a Hetzner S3 (Frankfurt) storage box.  
Instances are split across **3 primary servers**:
- **Admin Panel (Hetzner VPS, US):** Beszel, Uptime Kuma, OwlBank
- **Oracle Free Tier (US):** UmberWood, FoundryVTT
- **Oracle Free Tier (AU):** Calibre

---

## Services

### 🎲 FoundryVTT
- **Description:** A self-hosted virtual tabletop for Dungeons & Dragons campaigns.
- **Image:** `felddy/foundryvtt:13`
- **Depends on:** Docker, persistent volume (`foundry-data`)
- **Ports:** `30000:30000`
- **Environment:**
  - `FOUNDRY_USERNAME`
  - `FOUNDRY_PASSWORD`
  - `FOUNDRY_ADMIN_KEY`
- **Server:** Oracle Free Tier (US)
- **Notes:** World data lives in `foundry-data` volume.

---

### 🖥️ Beszel
- **Description:** Hardware monitoring dashboard.
- **Image:** `henrygd/beszel:latest`
- **Ports:** `8090:8090`
- **Volumes:** 
  - `beszel_data` (persistent data)
  - `./beszel_socket` (local socket)
- **Server:** Hetzner Admin Panel (US)
- **Notes:** Dashboards/alerts configured for infra.

---

### 📚 Calibre
- **Description:** Web-based ebook manager (Calibre Web).
- **Image:** `lscr.io/linuxserver/calibre-web:latest`
- **Ports:** `8083:8083`
- **Volumes:**
  - `calibre-books` → stores book library
  - `calibre-data` → app config
- **Server:** Oracle Free Tier (AU)
- **Environment:**
  - `PUID`, `PGID`, `TZ`
- **Notes:** Library backed up to Hetzner S3.

---

### 📡 Uptime Kuma
- **Description:** Networking uptime/status monitor.
- **Image:** `louislam/uptime-kuma:latest`
- **Ports:** (default internal port, reverse proxy handled)
- **Volumes:** `uptime-kuma-data`
- **Server:** Hetzner Admin Panel (US)
- **Notes:** Tracks uptime of all external-facing services. Alerts to Discord

---

### 🐦 UmberWood
- **Description:** Discord bot + databases for the UmberWood project.
- **Image:** `ghcr.io/rhomelab/red-discordbot:latest`
- **Environment:**
  - `TOKEN`
  - `INSTANCE_NAME=umberwood`
  - `PREFIX=uw:`
  - `TEAM_MEMBERS_ARE_OWNERS=TRUE`
- **Volumes:** `umberwood-data` (persistent bot data)
- **Server:** Oracle Free Tier (US)
- **Notes:** Bot data stored in mounted volume, backups weekly.

---

### 🏦 OwlBank
- **Description:** Mock banking service for the "Go Skate" project.
- **Image:** `dumbwareio/dumbbudget:latest`
- **Ports:** `3862:3000`
- **Volumes:** `owlbank-data`
- **Environment:**
  - `DUMBBUDGET_PIN`
  - `DUMBBUDGET_BASE_URL`
  - `DUMBBUDGET_CURRENCY`
  - `DUMBBUDGET_SITE_TITLE`
  - `DUMBBUDGET_INSTANCE_NAME`
- **Server:** Hetzner Admin Panel (US)
