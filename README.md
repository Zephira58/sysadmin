# 🖥️ Personal Infrastructure

This repository contains the configuration, services, and automation I use to manage my personal infrastructure.  
Everything is primarily managed through **Dockploy** with Docker/Docker Compose as the foundation.  

The goal is to keep all sysadmin-related work **versioned, documented, and reproducible** — so I can rebuild or expand my environment quickly.

---

## 📂 Repository Structure
```
├─ services/ # Service definitions (Dockerfiles, configs, templates)
├─ deployments/ # Dockploy YAMLs for live environments
├─ scripts/ # Backup, restore, and utility scripts
├─ traefik/ # Reverse proxy configs
├─ docs/ # Documentation and runbooks
└─ README.md # You're here
```

---

## 🚀 Usage

### Clone Repo
```bash
git clone https://github.com/Zephira58/sysadmin.git
cd sysadmin
```

