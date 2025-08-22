# Disaster Recovery Guide

This document explains how to restore services after a server wipe.  
Backups are stored in Hetzner S3 (Frankfurt).

---

## 1. Provision Servers
- Oracle Free Tier (US) → FoundryVTT, UmberWood
- Oracle Free Tier (AU) → Calibre
- Hetzner VPS (US) → Admin Panel (Beszel, Uptime Kuma, OwlBank)

Install required software:
```bash
apt update && apt install -y docker docker-compose
```

---

## 2. Restore Volumes and ENV's
Each service uses **external Docker volumes**. Restore them from S3 backups:

- `foundry-data`
- `umberwood-data`
- `calibre-books`
- `calibre-data`
- `uptime-kuma-data`
- `beszel_data`
- `owlbank-data`

Env files for each service can be located in the /env folder, only in the local copy of this repo. Its excluded from the github listing for security

---

## 3. Redeploy Services

### 3a. Manual Deployment
1. Navigate to the deployment folder of the desired service:
```bash
cd /path/to/deployment
```
2. Start the stack with Docker Compose:
```bash
docker-compose up -d
```
3. Verify volumes and environment variables are correctly mapped.

### 3b. Dockploy Deployment
Dockploy is a self-hosted deployment platform that simplifies multi-server management.

#### 3b.1 Initial Setup
1. Install Dockploy on your primary server:
```bash
curl -sSL https://dokploy.com/install.sh | sh
```
2. Access the Dockploy web interface at `http://<server-ip>:3000`.
3. Create an admin account for managing deployments.

#### 3b.2 Adding Remote Servers
1. Generate an SSH key pair in the Dockploy dashboard under **Settings > SSH Keys**.
2. Copy the public key to each remote server's `~/.ssh/authorized_keys`.
3. Add the server in Dockploy (**Settings > Servers**) with:
   - Name (descriptive)
   - IP Address
   - SSH Port (default 22)
   - Username
   - Select the SSH key generated
4. Test the connection via Dockploy's terminal feature.

#### 3b.3 Deploy Applications
1. Create a deployment in Dockploy (**Project Name > Create Service**).
2. Choose target servers.
3. Select the repository or Docker Compose file.
4. Click **Deploy**.

#### 3b.4 Managing Multiple Servers
- View all servers and their statuses in **Servers**.
- Edit server details as needed.
- Remove servers via the **Remove Server** option.

---

## 4. Service Notes
- **FoundryVTT:** Requires `FOUNDRY_USERNAME`, `FOUNDRY_PASSWORD`, `FOUNDRY_ADMIN_KEY`. Restore `foundry-data`.
- **Beszel:** Restore `beszel_data` volume.
- **Calibre:** Restore `calibre-books` and `calibre-data`.
- **Uptime Kuma:** Restore `uptime-kuma-data`.
- **UmberWood:** Restore `umberwood-data` and re-inject `TOKEN`.
- **OwlBank:** Restore `owlbank-data` and environment variables.

---

## 5. Verification
- Uptime Kuma shows all services green.
- FoundryVTT loads saved campaigns.
- UmberWood bot responds in Discord.
- Calibre web interface shows library.
- OwlBank dashboard is reachable.
- Beszel metrics streaming from all nodes.