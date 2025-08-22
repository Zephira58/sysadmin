# Monitoring & Alerts

This document explains how monitoring is set up for the sysadmin stack, including Uptime Kuma and Beszel.

## 1. Alerting

- All alerts are sent to a private Discord server via webhook.
- No email or SMS alerts are configured.
- Alerts should be checked daily for false positives and outages.

## 2. Uptime Kuma

**Dashboard URL:** https://status.zephira.uk/dashboard

**Monitored Services:**

- **FoundryVTT** → https://foundryvtt.zephira.uk/
- **Calibre** → Calibre AU Oracle server
- **OwlBank** → OwlBank admin panel

**Frequency:**
- SSL certificate expiry is monitored (notifications before expiration).

**Example metrics:**

- Response time (ms)
- Uptime % (24h, 30d)
- SSL Expiry countdown

**Recovery Steps:**

- If a monitor is DOWN, verify with `docker ps` on the relevant server.
- Check logs with `docker logs <container>`.
- If SSL is expired, renew via Traefik or Let’s Encrypt process.

## 3. Beszel

**Dashboard URL:** https://monitor.zephira.uk/

**Monitored Hosts:**

- **HetznerVPS (Admin Panel)** → Beszel, Uptime Kuma, OwlBank
- **OracleVPS (US)** → FoundryVTT, UmberWood
- **OracleVPS (AU)** → Calibre
- **Local PC (zephipc)** → monitored but no alerts configured

**Metrics Collected:**

- CPU %
- Memory usage %
- Disk usage %
- GPU usage % (if applicable)
- Load average
- Network I/O
- Temperature

**Alerts:**

- Enabled on all servers except local PC (zephipc).
- Typical triggers: high memory, high disk usage, or high load average.

## 4. What To Do When Alerts Fire

- Check Beszel to see resource strain.
  - High CPU → see if Docker container is looping.
  - High memory → restart service or scale resources.
  - High disk → clean logs, prune Docker volumes, expand storage.
- Check Uptime Kuma to confirm service is actually down.
- If confirmed outage:
  - Run recovery steps from `recovery.md`.
  - If persistent, check backup restore process.

## 5. Status Pages

- Uptime Kuma can expose a public status page if needed.
- Currently, monitoring is via global dashboard.
