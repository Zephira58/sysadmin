# Troubleshooting Guide

This document provides basic troubleshooting steps for all services in the sysadmin stack.

---

## 1. FoundryVTT

**Description:** Dungeons & Dragons virtual tabletop game engine.

**Common Issues & Fixes:**

* **Service not starting:**

  * Check `docker logs foundryvtt` for errors.
  * Ensure environment variables (`FOUNDRY_USERNAME`, `FOUNDRY_PASSWORD`, `FOUNDRY_ADMIN_KEY`) are correctly set.
  * Verify `foundry-data` volume exists and has proper permissions.
* **Unable to access web interface:**

  * Check port mapping `30000:30000`.
  * Verify server firewall allows access.
  * Check Cloudflare routing.
* **Data missing or corrupted:**

  * Restore from backup volume `foundry-data`.

---

## 2. Uptime Kuma

**Description:** Networking uptime monitor.

**Common Issues & Fixes:**

* **Dashboard not reachable:**

  * Check `docker logs uptime-kuma`.
  * Verify reverse proxy configuration.
  * Ensure `uptime-kuma-data` volume is intact.
* **Monitors not updating:**

  * Confirm network access to monitored services.
  * Restart Uptime Kuma container.

---

## 3. Beszel

**Description:** Hardware monitoring dashboard.

**Common Issues & Fixes:**

* **Metrics not showing:**

  * Verify agent is running on monitored hosts.
  * Check container logs: `docker logs beszel`.
* **High resource usage alerts incorrect:**

  * Confirm thresholds are configured properly.

---

## 4. UmberWood

**Description:** Discord bot for UmberWood project.

**Common Issues & Fixes:**

* **Bot not responding:**

  * Check `docker logs umberwood`.
  * Verify `TOKEN` environment variable is set.
  * Ensure bot is connected to the correct Discord server.
* **Data loss:**

  * Restore `umberwood-data` volume from backup.

---

## 5. Calibre

**Description:** Web-based book manager.

**Common Issues & Fixes:**

* **Web interface unreachable:**

  * Verify port `8083` is accessible.
  * Check `docker logs calibre`.
* **Library missing or corrupted:**

  * Restore `calibre-books` and `calibre-data` volumes.

---

## 6. OwlBank

**Description:** Mock banking service for "Go Skate".

**Common Issues & Fixes:**

* **Dashboard not reachable:**

  * Check port mapping `3862:3000`.
  * Verify container logs: `docker logs owlbank`.
* **Data issues:**

  * Restore `owlbank-data` volume.
  * Re-apply environment variables (`DUMBBUDGET_PIN`, `DUMBBUDGET_BASE_URL`, etc.).

---

## 7. Zephira.uk (Portfolio Website)

**Description:** Static personal portfolio hosted at [https://zephira.uk](https://zephira.uk).

**Common Issues & Fixes:**

* **Website not loading:**

  * Verify container logs: `docker logs zephislibrary`.
  * Check Nginx/Traefik reverse proxy configuration.
  * Confirm DNS records at Cloudflare point to the correct server.
* **SSL issues:**

  * Run certificate renewal (`certbot renew` or Traefik auto-renew).
  * Ensure Cloudflare SSL mode is set to **Full (Strict)**.
* **Content outdated:**

  * Pull latest repo changes:

    ```bash
    cd /services/zephislibrary
    git pull origin main
    docker-compose up -d --build
    ```
* **Performance problems:**

  * Check server load in Beszel.
  * Verify CDN caching via Cloudflare is enabled.

---

## 8. Karakeep

**Description:** Self-hosted note-taking/knowledge base app running on AU Oracle VPS.

**Common Issues & Fixes:**

* **Service not starting:**

  * Check `docker logs karakeep`.
  * Ensure both `karakeep-data` and `meilisearch-data` volumes exist.
  * Verify environment variables are set for authentication and Meilisearch.
* **Search not working:**

  * Confirm Meilisearch container is running: `docker ps | grep meilisearch`.
  * Check logs for indexing issues: `docker logs meilisearch`.
* **Data missing or corrupted:**

  * Restore `karakeep-data` and `meilisearch-data` volumes from backup.
* **Web interface unreachable:**

  * Verify correct port mapping.
  * Check reverse proxy (Traefik/Nginx) configuration.
  * Confirm AU Oracle server is reachable externally.

## 9. EZBookkeeping

**Description:** Lightweight self-hosted bookkeeping app deployed via Docker.

**Common Issues & Fixes:**

* **Service not starting:**
  * Check `docker logs ezbookkeeping` for errors.
  * Ensure MySQL container is running and accessible.
  * Verify environment variables are correctly set:

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

* **Web interface unreachable:**
  * Confirm port mapping in `docker-compose.yml`.
  * Check reverse proxy configuration.
  * Verify DNS records point to the correct server.

* **Database connection errors:**
  * Ensure `EBK_DATABASE_HOST` matches the MySQL container name and port.
  * Confirm credentials (`EBK_DATABASE_USER`, `EBK_DATABASE_PASSWD`) match MySQL setup.
  * Check consistency between `MYSQL_DATABASE` and `EBK_DATABASE_NAME`.

* **Data loss or corruption:**
  * Restore MySQL volume from backup.
  * Verify `.env` file integrity and database dumps.