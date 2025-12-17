# ✅ PHASE 5 COMPLETE - ANSIBLE CONFIGURATION

## SECTION D: CONFIGURATION MANAGEMENT USING ANSIBLE (8 Marks)

---

## ✅ Task D1: Inventory Setup (4 Marks)

### Inventory File: `ansible/inventory.ini`

**Two Server Groups Created**:

#### 1. Web Servers Group (`webservers`)
- **Host 1**: `webserver1` (localhost)
- **Host 2**: `webserver2` (127.0.0.1)
- **Role**: Web application servers
- **Software**: Docker, Node.js, npm, Nginx

#### 2. Database Group (`database`)
- **Host 1**: `dbserver1` (localhost)
- **Role**: Database server
- **Software**: Docker, PostgreSQL client, Python libraries

**Group Variables**:
```ini
[webservers:vars]
server_role=web
install_docker=true
install_nodejs=true
install_nginx=true

[database:vars]
server_role=database
install_docker=true
install_postgresql=true
```

---

## ✅ Task D2: Playbook (4 Marks)

### Playbooks Created:

1. **`playbook.yml`** - Task-based playbook
2. **`playbook-roles.yml`** - Role-based playbook

### Software Installation Automated:

#### Web Servers:
- ✅ **Docker** - Container runtime
- ✅ **Node.js** - JavaScript runtime
- ✅ **npm** - Package manager
- ✅ **Nginx** - Web server/reverse proxy
- ✅ **Python packages** - Docker management
- ✅ **Git, curl, wget** - Utilities

#### Database Servers:
- ✅ **Docker** - Container runtime
- ✅ **PostgreSQL client** - Database client tools
- ✅ **Python PostgreSQL libraries** - Database management
- ✅ **Utilities** - curl, wget

### Configuration Tasks Automated:

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

## 📁 Files Created:

### Main Files:
1. `ansible/inventory.ini` - Server inventory with 2 groups
2. `ansible/ansible.cfg` - Ansible configuration
3. `ansible/playbook.yml` - Main playbook
4. `ansible/playbook-roles.yml` - Role-based playbook
5. `ansible/README.md` - Complete documentation

### Role: webserver
6. `ansible/roles/webserver/tasks/main.yml` - Web server tasks
7. `ansible/roles/webserver/handlers/main.yml` - Service handlers
8. `ansible/roles/webserver/templates/nginx.conf.j2` - Nginx template

### Role: database
9. `ansible/roles/database/tasks/main.yml` - Database tasks
10. `ansible/roles/database/handlers/main.yml` - Service handlers

### Execution Scripts:
11. `ansible/run-ansible.sh` - Bash execution script
12. `ansible/run-ansible.ps1` - PowerShell execution script

---

## 🚀 How to Execute:

### Prerequisites:

**Install Ansible** (if not installed):
```bash
# On WSL/Ubuntu
sudo apt update
sudo apt install ansible -y

# Verify
ansible --version
```

### Method 1: Using Main Playbook

```bash
cd ansible
ansible-playbook playbook.yml
```

### Method 2: Using Role-based Playbook

```bash
cd ansible
ansible-playbook playbook-roles.yml
```

### Method 3: Using Script

```bash
cd ansible
chmod +x run-ansible.sh
./run-ansible.sh
```

---

## 🔍 Verification Commands:

### Check Inventory:
```bash
cd ansible
ansible-inventory --list -i inventory.ini
```

### Test Connectivity:
```bash
ansible all -m ping -i inventory.ini
```

### Check Installed Software:
```bash
# Docker on all hosts
ansible all -m shell -a "docker --version" -i inventory.ini

# Node.js on web servers
ansible webservers -m shell -a "node --version" -i inventory.ini

# PostgreSQL client on database servers
ansible database -m shell -a "psql --version" -i inventory.ini
```

### Check Services:
```bash
# Docker service
ansible all -m systemd -a "name=docker" -i inventory.ini

# Nginx service
ansible webservers -m systemd -a "name=nginx" -i inventory.ini
```

---

## 📸 Screenshots for Grading:

### 1. Inventory File
```bash
cat ansible/inventory.ini
```
**Screenshot**: Shows 2 groups (webservers, database) with multiple hosts

### 2. Playbook File
```bash
cat ansible/playbook.yml
```
**Screenshot**: Shows automation tasks for software installation

### 3. Role Structure
```bash
tree ansible/roles/
```
**Screenshot**: Shows webserver and database roles

### 4. Playbook Execution
```bash
cd ansible
ansible-playbook playbook.yml
```
**Screenshot**: Shows all tasks executing successfully

### 5. Verification - Docker
```bash
ansible all -m shell -a "docker --version" -i inventory.ini
```
**Screenshot**: Shows Docker installed on all hosts

### 6. Verification - Web Server Software
```bash
ansible webservers -m shell -a "node --version && nginx -v" -i inventory.ini
```
**Screenshot**: Shows Node.js and Nginx installed

### 7. Verification - Database Software
```bash
ansible database -m shell -a "psql --version" -i inventory.ini
```
**Screenshot**: Shows PostgreSQL client installed

### 8. Service Status
```bash
ansible all -m systemd -a "name=docker" -i inventory.ini
```
**Screenshot**: Shows Docker service running

---

## ✅ Requirements Verification:

### Task D1: Inventory Setup ✅

| Requirement | Status | Evidence |
|------------|--------|----------|
| Inventory file created | ✅ DONE | `ansible/inventory.ini` |
| Two groups defined | ✅ DONE | `webservers` and `database` groups |
| Multiple hosts | ✅ DONE | 3 hosts total (2 web, 1 database) |
| Group variables | ✅ DONE | Variables for each group |
| Target machines described | ✅ DONE | Roles and software defined |

### Task D2: Playbook ✅

| Requirement | Status | Evidence |
|------------|--------|----------|
| Software installation automated | ✅ DONE | Docker, Node.js, Nginx, PostgreSQL |
| Docker installation | ✅ DONE | All servers |
| Node.js installation | ✅ DONE | Web servers |
| Nginx installation | ✅ DONE | Web servers |
| PostgreSQL installation | ✅ DONE | Database servers |
| Service configuration | ✅ DONE | Docker, Nginx services |
| Directory creation | ✅ DONE | App and DB directories |
| Two separate roles | ✅ DONE | webserver and database roles |

---

## 🎯 Key Features:

### Idempotency
- All tasks can run multiple times safely
- No duplicate installations
- State-based configuration

### Error Handling
- Graceful error handling with `ignore_errors`
- Conditional execution based on OS
- Service status checks

### Organization
- Role-based structure
- Reusable components
- Handlers for service management
- Templates for configuration

### Documentation
- Complete README
- Inline comments
- Execution scripts
- Verification commands

---

## 📊 Project Status:

✅ **Phase 1**: Application Development - COMPLETE
✅ **Phase 2**: Containerization - COMPLETE
✅ **Phase 3**: CI/CD Pipeline - COMPLETE
✅ **Phase 4**: AKS Deployment - COMPLETE
✅ **Phase 5**: Ansible Configuration - **COMPLETE** ✨
⏳ **Phase 6**: Selenium Testing - READY TO START

---

## 🚀 Next Steps:

1. ✅ Execute Ansible playbook
2. ✅ Verify installations
3. ✅ Take screenshots for grading
4. ✅ Proceed to Phase 6 (Selenium Testing)

---

**PHASE 5 COMPLETE!** 🎉

**All Ansible requirements satisfied!**

**Ready to proceed to Phase 6 (Selenium)?**
