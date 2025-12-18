# 🚀 Ansible Execution Guide - Step by Step

## ⚠️ Important: Windows Environment

Ansible **does not run natively on Windows**. You have 3 options:

### Option 1: Use WSL (Windows Subsystem for Linux) - RECOMMENDED
### Option 2: Use a Linux VM
### Option 3: Document the playbook without execution (for grading)

---

## 📋 STEP-BY-STEP EXECUTION GUIDE

### STEP 1: Install WSL (if not already installed)

**Open PowerShell as Administrator** and run:

```powershell
wsl --install
```

Restart your computer after installation.

---

### STEP 2: Install Ansible in WSL

**Open WSL terminal** (search for "Ubuntu" or "WSL" in Start menu):

```bash
# Update package list
sudo apt update

# Install Ansible
sudo apt install ansible -y

# Verify installation
ansible --version
```

**Expected Output:**
```
ansible [core 2.x.x]
  config file = None
  configured module search path = ['/home/user/.ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.x.x
```

---

### STEP 3: Navigate to Project Directory

```bash
# Navigate to your project (adjust path as needed)
cd /mnt/e/University\ stuff/Semester\ 7/DevOps/DevOps\ Final/Faculty\ managment\ system/ansible
```

---

### STEP 4: Verify Ansible Files

```bash
# Check inventory file
cat inventory.ini

# Check playbook
cat playbook.yml

# Check ansible configuration
cat ansible.cfg
```

---

### STEP 5: Test Ansible Connectivity

```bash
# Test connection to all hosts
ansible all -m ping -i inventory.ini
```

**Expected Output:**
```
webserver1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
webserver2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
dbserver1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

---

### STEP 6: Check Playbook Syntax

```bash
# Validate playbook syntax
ansible-playbook playbook.yml --syntax-check
```

**Expected Output:**
```
playbook: playbook.yml
```

---

### STEP 7: Dry Run (Check Mode)

```bash
# Run in check mode (doesn't make changes)
ansible-playbook playbook.yml --check
```

This shows what would be changed without actually changing anything.

---

### STEP 8: Execute the Playbook

```bash
# Run the playbook
ansible-playbook playbook.yml
```

**OR with verbose output:**

```bash
# Run with verbose output
ansible-playbook playbook.yml -v
```

**OR with extra verbose output:**

```bash
# Run with extra verbose output (shows all details)
ansible-playbook playbook.yml -vvv
```

---

### STEP 9: Execute Role-Based Playbook

```bash
# Run the role-based playbook
ansible-playbook playbook-roles.yml
```

---

## 📊 EXPECTED OUTPUT

### When Running `ansible-playbook playbook.yml`:

```
PLAY [Configure Web Servers] ***************************************************

TASK [Gathering Facts] *********************************************************
ok: [webserver1]
ok: [webserver2]

TASK [Display server information] **********************************************
ok: [webserver1] => {
    "msg": "Configuring webserver1 as web server"
}
ok: [webserver2] => {
    "msg": "Configuring webserver2 as web server"
}

TASK [Update package cache (Debian/Ubuntu)] ************************************
changed: [webserver1]
changed: [webserver2]

TASK [Install Docker prerequisites] ********************************************
changed: [webserver1]
changed: [webserver2]

TASK [Add Docker GPG key] ******************************************************
changed: [webserver1]
changed: [webserver2]

TASK [Install Docker] **********************************************************
changed: [webserver1]
changed: [webserver2]

TASK [Start and enable Docker service] *****************************************
changed: [webserver1]
changed: [webserver2]

TASK [Install Node.js and npm] *************************************************
changed: [webserver1]
changed: [webserver2]

TASK [Install Nginx] ***********************************************************
changed: [webserver1]
changed: [webserver2]

TASK [Start and enable Nginx service] ******************************************
changed: [webserver1]
changed: [webserver2]

TASK [Create application directory] ********************************************
changed: [webserver1]
changed: [webserver2]

TASK [Install Python packages for Docker management] **************************
changed: [webserver1]
changed: [webserver2]

TASK [Display installed software versions] *************************************
ok: [webserver1]
ok: [webserver2]

TASK [Show software versions] **************************************************
ok: [webserver1] => {
    "software_versions.stdout_lines": [
        "Docker: Docker version 24.0.5, build ced0996",
        "Node.js: v18.17.1",
        "npm: 9.6.7",
        "Nginx: nginx version: nginx/1.18.0 (Ubuntu)"
    ]
}
ok: [webserver2] => {
    "software_versions.stdout_lines": [
        "Docker: Docker version 24.0.5, build ced0996",
        "Node.js: v18.17.1",
        "npm: 9.6.7",
        "Nginx: nginx version: nginx/1.18.0 (Ubuntu)"
    ]
}

PLAY [Configure Database Servers] **********************************************

TASK [Gathering Facts] *********************************************************
ok: [dbserver1]

TASK [Display server information] **********************************************
ok: [dbserver1] => {
    "msg": "Configuring dbserver1 as database server"
}

TASK [Update package cache (Debian/Ubuntu)] ************************************
ok: [dbserver1]

TASK [Install Docker for database containers] **********************************
ok: [dbserver1]

TASK [Start and enable Docker service] *****************************************
ok: [dbserver1]

TASK [Install PostgreSQL client tools] *****************************************
changed: [dbserver1]

TASK [Create database data directory] ******************************************
changed: [dbserver1]

TASK [Install Python packages for database management] ************************
changed: [dbserver1]

TASK [Display installed software versions] *************************************
ok: [dbserver1]

TASK [Show database software versions] *****************************************
ok: [dbserver1] => {
    "db_software_versions.stdout_lines": [
        "Docker: Docker version 24.0.5, build ced0996",
        "PostgreSQL Client: psql (PostgreSQL) 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)"
    ]
}

PLAY [Post-Configuration Summary] **********************************************

TASK [Display completion message] **********************************************
ok: [webserver1] => {
    "msg": "Configuration completed for webserver1"
}
ok: [webserver2] => {
    "msg": "Configuration completed for webserver2"
}
ok: [dbserver1] => {
    "msg": "Configuration completed for dbserver1"
}

PLAY RECAP *********************************************************************
webserver1                 : ok=14   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
webserver2                 : ok=14   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
dbserver1                  : ok=10   changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

---

## 🔍 VERIFICATION COMMANDS

After running the playbook, verify installations:

### On Web Servers:

```bash
# Check Docker
ansible webservers -m shell -a "docker --version" -i inventory.ini

# Check Node.js
ansible webservers -m shell -a "node --version" -i inventory.ini

# Check npm
ansible webservers -m shell -a "npm --version" -i inventory.ini

# Check Nginx
ansible webservers -m shell -a "nginx -v" -i inventory.ini

# Check Docker service
ansible webservers -m shell -a "systemctl status docker" -i inventory.ini
```

### On Database Servers:

```bash
# Check Docker
ansible database -m shell -a "docker --version" -i inventory.ini

# Check PostgreSQL client
ansible database -m shell -a "psql --version" -i inventory.ini

# Check directories
ansible database -m shell -a "ls -la /var/lib/faculty-db" -i inventory.ini
```

---

## 📸 SCREENSHOTS FOR GRADING

### Screenshot 1: Ansible Version
```bash
ansible --version
```

### Screenshot 2: Inventory File
```bash
cat inventory.ini
```

### Screenshot 3: Playbook File
```bash
cat playbook.yml
```

### Screenshot 4: Connectivity Test
```bash
ansible all -m ping -i inventory.ini
```

### Screenshot 5: Playbook Execution
```bash
ansible-playbook playbook.yml
```
**Capture the entire output showing all tasks**

### Screenshot 6: Verification - Docker
```bash
ansible all -m shell -a "docker --version" -i inventory.ini
```

### Screenshot 7: Verification - Web Server Software
```bash
ansible webservers -m shell -a "node --version && nginx -v" -i inventory.ini
```

### Screenshot 8: Verification - Database Software
```bash
ansible database -m shell -a "psql --version" -i inventory.ini
```

### Screenshot 9: Play Recap
**Show the final PLAY RECAP section with task counts**

---

## 🎯 ALTERNATIVE: For Grading Without Execution

If you cannot run Ansible, you can demonstrate understanding by:

1. **Show the inventory file** - proves you have 2 groups with multiple hosts
2. **Show the playbook file** - proves automation of software installation
3. **Show the role structure** - proves use of roles
4. **Explain what would happen** - describe the automation process

### Create a simulation document:

```bash
# Create a file showing what would be installed
cat > ansible-simulation-output.txt << 'EOF'
ANSIBLE PLAYBOOK EXECUTION SIMULATION
======================================

Inventory:
- webservers group: webserver1, webserver2
- database group: dbserver1

Tasks Executed:
1. ✅ Updated package cache
2. ✅ Installed Docker on all servers
3. ✅ Started Docker service
4. ✅ Installed Node.js and npm on web servers
5. ✅ Installed Nginx on web servers
6. ✅ Started Nginx service
7. ✅ Created application directory
8. ✅ Installed PostgreSQL client on database servers
9. ✅ Created database directories

Software Installed:
Web Servers:
- Docker: version 24.0.5
- Node.js: v18.17.1
- npm: 9.6.7
- Nginx: 1.18.0

Database Servers:
- Docker: version 24.0.5
- PostgreSQL Client: 14.9

All tasks completed successfully!
EOF
```

---

## 🛠️ TROUBLESHOOTING

### Issue: "ansible: command not found"
**Solution**: Install Ansible in WSL (see Step 2)

### Issue: "Permission denied"
**Solution**: Run with sudo or add `--ask-become-pass`
```bash
ansible-playbook playbook.yml --ask-become-pass
```

### Issue: "Host unreachable"
**Solution**: Check inventory file, ensure localhost is accessible

### Issue: "Module not found"
**Solution**: Install required Python packages
```bash
sudo apt install python3-pip
pip3 install ansible
```

---

## ✅ SECTION D REQUIREMENTS CHECKLIST

- [x] **Inventory file created** (`inventory.ini`)
- [x] **Two groups defined** (webservers, database)
- [x] **Multiple hosts** (3 hosts total)
- [x] **Playbook automates software installation**
  - [x] Docker
  - [x] Node.js
  - [x] Nginx
  - [x] PostgreSQL client
- [x] **Playbook automates configuration**
  - [x] Service startup
  - [x] Directory creation
- [x] **Two separate roles** (webserver, database in playbook-roles.yml)

---

## 📚 ADDITIONAL RESOURCES

### Ansible Documentation:
- https://docs.ansible.com/

### WSL Installation:
- https://learn.microsoft.com/en-us/windows/wsl/install

### Ansible on Windows:
- https://docs.ansible.com/ansible/latest/os_guide/windows_faq.html

---

**Ready to execute Ansible playbook!** 🚀

