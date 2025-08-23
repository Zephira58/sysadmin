# Monitoring & Alerts

This document explains how monitoring and alerting is configured for the sysadmin stack, covering **Uptime Kuma** for service uptime and SSL monitoring, and **Beszel** for host system metrics.

---

## 1. Alerting

* All alerts are delivered to a **private Discord server** via webhook.
* No email or SMS alerts are configured.
* Alerts should be checked daily for false positives and outages.

---

## 2. Uptime Kuma

**Dashboard URL:** [https://status.zephira.uk/dashboard](https://status.zephira.uk/dashboard)

**Monitored Services:**

* **FoundryVTT** → [https://foundryvtt.zephira.uk/](https://foundryvtt.zephira.uk/) (OracleVPS US)
* **Calibre** → Calibre AU Oracle server
* **OwlBank** → OwlBank admin panel (HetznerVPS)
* **Personal Website** → [https://zephira.uk](https://zephira.uk) (HetznerVPS / Dokploy server)
* **Karakeep** → AU Oracle server

**Frequency:**

* Monitors run every **60 seconds**.
* SSL certificate expiry is tracked with advance warnings before expiration.

**Example Metrics:**

* Response time (ms)
* Uptime % (24h, 30d)
* SSL Expiry countdown

**Recovery Steps:**

1. If a monitor is DOWN, verify with `docker ps` on the relevant server.
2. Check logs with `docker logs <container>`.
3. If SSL certificate is expired, renew via **Traefik / Let’s Encrypt**.

---

## 3. Beszel

**Dashboard URL:** [https://monitor.zephira.uk/](https://monitor.zephira.uk/)

**Monitored Hosts:**

* **HetznerVPS (Admin Panel / Dokploy)** → Beszel, Uptime Kuma, OwlBank, Personal Website
* **OracleVPS (US)** → FoundryVTT, UmberWood
* **OracleVPS (AU)** → Calibre, Karakeep
* **Local PC (zephipc)** → monitored but **no alerts** configured

**Metrics Collected:**

* CPU %
* Memory usage %
* Disk usage %
* GPU usage % (if available)
* Load average
* Network I/O
* Temperature

**Alerts:**

* Enabled on all servers except **local PC (zephipc)**.
* Typical triggers:

  * High memory usage
  * High disk usage
  * High CPU/load average

---

## 4. What To Do When Alerts Fire

1. **Check Beszel** → look for system resource strain.

   * High CPU → check if a Docker container is looping.
   * High memory → restart service or scale resources.
   * High disk → clean logs, prune Docker volumes, or expand storage.

2. **Check Uptime Kuma** → confirm if the service is actually down.

3. If outage is confirmed:

   * Follow recovery steps in `recovery.md`.
   * If persistent, escalate to backup restore process.

---

## 5. Status Pages

* **Uptime Kuma** supports a public-facing status page.
* Currently, only the internal dashboard is in use.
* Public exposure can be enabled later if needed.
