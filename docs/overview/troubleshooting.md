# Troubleshooting Guide

This document provides basic troubleshooting steps for all services in the sysadmin stack.

---

## 1. FoundryVTT
**Description:** Dungeons & Dragons virtual tabletop game engine.

**Common Issues & Fixes:**
- **Service not starting:**
  - Check `docker logs foundryvtt` for errors.
  - Ensure environment variables (`FOUNDRY_USERNAME`, `FOUNDRY_PASSWORD`, `FOUNDRY_ADMIN_KEY`) are correctly set.
  - Verify `foundry-data` volume exists and has proper permissions.
- **Unable to access web interface:**
  - Check port mapping `30000:30000`.
  - Verify server firewall allows access.
  - Check cloudflare routing
- **Data missing or corrupted:**
  - Restore from backup volume `foundry-data`.

---

## 2. Uptime Kuma
**Description:** Networking uptime monitor.

**Common Issues & Fixes:**
- **Dashboard not reachable:**
  - Check `docker logs uptime-kuma`.
  - Verify reverse proxy configuration.
  - Ensure `uptime-kuma-data` volume is intact.
- **Monitors not updating:**
  - Confirm network access to monitored services.
  - Restart Uptime Kuma container.

---

## 3. Beszel
**Description:** Hardware monitoring dashboard.

**Common Issues & Fixes:**
- **Metrics not showing:**
  - Verify agent is running on monitored hosts.
  - Check container logs: `docker logs beszel`.
- **High resource usage alerts incorrect:**
  - Confirm thresholds are configured properly.

---

## 4. UmberWood
**Description:** Discord bot for UmberWood project.

**Common Issues & Fixes:**
- **Bot not responding:**
  - Check `docker logs umberwood`.
  - Verify `TOKEN` environment variable is set.
  - Ensure bot is connected to the correct Discord server.
- **Data loss:**
  - Restore `umberwood-data` volume from backup.

---

## 5. Calibre
**Description:** Web-based book manager.

**Common Issues & Fixes:**
- **Web interface unreachable:**
  - Verify port `8083` is accessible.
  - Check `docker logs calibre`.
- **Library missing or corrupted:**
  - Restore `calibre-books` and `calibre-data` volumes.

---

## 6. OwlBank
**Description:** Mock banking service for "Go Skate".

**Common Issues & Fixes:**
- **Dashboard not reachable:**
  - Check port mapping `3862:3000`.
  - Verify container logs: `docker logs owlbank`.
- **Data issues:**
  - Restore `owlbank-data` volume.
  - Re-apply environment variables (`DUMBBUDGET_PIN`, `DUMBBUDGET_BASE_URL`, etc.).
