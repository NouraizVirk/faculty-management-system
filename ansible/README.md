# Ansible Configuration for Faculty Management System

## Overview

This Ansible configuration automates the setup of infrastructure for the Faculty Management System with two distinct server roles:

1. **Web Servers** - Host frontend and backend applications
2. **Database Servers** - Host PostgreSQL database

---

## Files Structure

```
ansible/
├── ansible.cfg              # Ansible configuration
├── inventory.ini            # Server inventory with 2 groups
├── playbook.yml            # Main playbook (task-based)
├── playbook-roles.yml      # Role-based playbook
├── roles/
│   ├── webserver/          # Web server role
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   ├── handlers/
│   │   │   └── main.yml
│   │   └── templates/
│   │       └── nginx.conf.j2
│   └── database/           # Database server role
│       ├── tasks/
│       │   └── main.yml
│       └── handlers/
│           └── main.yml
└── README.md               # This file
```

---

## Inventory Setup (Task D1)

### Inventory File: `inventory.ini`

**Two Server Groups**:

1. **webservers** group:
   - `webserver1` - Configured for web applications
   - `webserver2` - Configured for web applications
   - Installs: Docker, Node.js, npm, Nginx

2. **database** group:
   - `dbserver1` - Configured for database
   - Installs: Docker, PostgreSQL client, Python PostgreSQL libraries

**Variables**:
- Group-specific variables define what software to install
- Common variables apply to all hosts

---

## Playbook Features (Task D2)

### Software Installation

#### Web Servers:
- ✅ Docker (container runtime)
- ✅ Node.js and npm (application runtime)
- ✅ Nginx (reverse proxy)
- ✅ Python packages for Docker management
- ✅ Git, curl, wget (utilities)

#### Database Servers:
- ✅ Docker (for database containers)
- ✅ PostgreSQL client tools
- ✅ Python PostgreSQL libraries
- ✅ Database management utilities

### Configuration Tasks

#### Web Servers:
- ✅ Start and enable Docker service
- ✅ Start and enable Nginx service
- ✅ Create application directory (`/opt/faculty-management`)
- ✅ Configure Nginx reverse proxy
- ✅ Install Python Docker management tools

#### Database Servers:
- ✅ Start and enable Docker service
- ✅ Create database data directory (`/var/lib/faculty-db`)
- ✅ Create backup directory (`/backup/faculty-db`)
- ✅ Install PostgreSQL client and libraries

---

## Prerequisites

### Install Ansible

**Windows (WSL)**:
```bash
sudo apt update
sudo apt install ansible -y
```

**Verify Installation**:
```bash
ansible --version
```

---

## Execution

### Method 1: Main Playbook (Task-based)

```bash
cd ansible
ansible-playbook playbook.yml
```

### Method 2: Role-based Playbook

```bash
cd ansible
ansible-playbook playbook-roles.yml
```

### Check Inventory

```bash
ansible-inventory --list -i inventory.ini
```

### Test Connectivity

```bash
ansible all -m ping -i inventory.ini
```

### Run Specific Group

```bash
# Only web servers
ansible-playbook playbook.yml --limit webservers

# Only database servers
ansible-playbook playbook.yml --limit database
```

---

## Verification

### Check Installed Software

```bash
# Check on all hosts
ansible all -m shell -a "docker --version" -i inventory.ini

# Check Node.js on web servers
ansible webservers -m shell -a "node --version" -i inventory.ini

# Check PostgreSQL client on database servers
ansible database -m shell -a "psql --version" -i inventory.ini
```

### Check Services

```bash
# Check Docker service
ansible all -m systemd -a "name=docker" -i inventory.ini

# Check Nginx service
ansible webservers -m systemd -a "name=nginx" -i inventory.ini
```

---

## Screenshots for Grading

### 1. Inventory File
```bash
cat inventory.ini
```
Screenshot showing:
- Two groups (webservers, database)
- Multiple hosts
- Group variables

### 2. Playbook Execution
```bash
ansible-playbook playbook.yml
```
Screenshot showing:
- All tasks executing
- Success messages
- No failures

### 3. Verification
```bash
ansible all -m shell -a "docker --version" -i inventory.ini
ansible webservers -m shell -a "nginx -v" -i inventory.ini
ansible database -m shell -a "psql --version" -i inventory.ini
```
Screenshot showing installed software versions

### 4. Role Structure
```bash
tree roles/
```
Screenshot showing role organization

---

## Troubleshooting

### Issue: Permission Denied

**Solution**: Ensure you have sudo privileges
```bash
ansible-playbook playbook.yml --ask-become-pass
```

### Issue: Connection Failed

**Solution**: Check inventory hosts are accessible
```bash
ansible all -m ping -i inventory.ini
```

### Issue: Package Not Found

**Solution**: Update package cache first
```bash
ansible all -m apt -a "update_cache=yes" -i inventory.ini --become
```

---

## Grading Checklist

### Task D1: Inventory Setup ✅
- [x] Inventory file created (`inventory.ini`)
- [x] Two groups defined (webservers, database)
- [x] Multiple hosts in inventory
- [x] Group variables configured
- [x] Common variables defined

### Task D2: Playbook ✅
- [x] Playbook automates software installation
- [x] Docker installation automated
- [x] Node.js installation automated
- [x] Nginx installation automated
- [x] PostgreSQL client installation automated
- [x] Service configuration automated
- [x] Directory creation automated
- [x] Two separate roles (webserver, database)

---

## Additional Features

### Roles
- Organized code structure
- Reusable components
- Handlers for service management
- Templates for configuration files

### Idempotency
- All tasks are idempotent
- Can run multiple times safely
- No duplicate installations

### Error Handling
- Graceful error handling with `ignore_errors`
- Conditional execution based on OS family
- Service status checks

---

## Next Steps

After running Ansible:
1. Verify all software installed
2. Check services are running
3. Take screenshots for submission
4. Proceed to Phase 6 (Selenium Testing)

---

**SECTION D COMPLETE!** ✅
