# 🚀 Run Ansible on WSL - Step by Step

## Step 1: Open WSL Terminal

1. Press `Windows Key`
2. Type `wsl` or `ubuntu`
3. Press Enter

---

## Step 2: Navigate to Project Directory

```bash
# Navigate to your project folder
cd /mnt/e/University\ stuff/Semester\ 7/DevOps/DevOps\ Final/Faculty\ managment\ system/ansible

# Verify you're in the right directory
pwd
ls -la
```

---

## Step 3: Install Ansible (if not installed)

```bash
# Update package list
sudo apt update

# Install Ansible
sudo apt install ansible -y

# Verify installation
ansible --version
```

---

## Step 4: Check Inventory File

```bash
# View inventory
cat inventory.ini
```

---

## Step 5: Test Connectivity

```bash
# Ping all hosts
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

## Step 6: Run the Playbook

```bash
# Run the main playbook
ansible-playbook playbook.yml

# OR with verbose output
ansible-playbook playbook.yml -v
```

---

## Step 7: Verify Installation

```bash
# Check Docker on all hosts
ansible all -m shell -a "docker --version" -i inventory.ini

# Check Node.js on web servers
ansible webservers -m shell -a "node --version" -i inventory.ini

# Check Nginx on web servers
ansible webservers -m shell -a "nginx -v" -i inventory.ini

# Check PostgreSQL on database servers
ansible database -m shell -a "psql --version" -i inventory.ini
```

---

## 📸 Take Screenshots of:

1. `ansible --version`
2. `cat inventory.ini`
3. `ansible all -m ping -i inventory.ini`
4. `ansible-playbook playbook.yml` (full output)
5. Verification commands

---

## ⚠️ If You Get Permission Errors:

```bash
# Run with sudo
sudo ansible-playbook playbook.yml

# OR add --ask-become-pass
ansible-playbook playbook.yml --ask-become-pass
```

---

## 🎯 Quick Command Sequence (Copy-Paste All):

```bash
cd /mnt/e/University\ stuff/Semester\ 7/DevOps/DevOps\ Final/Faculty\ managment\ system/ansible
sudo apt update
sudo apt install ansible -y
ansible --version
cat inventory.ini
ansible all -m ping -i inventory.ini
ansible-playbook playbook.yml
ansible all -m shell -a "docker --version" -i inventory.ini
```

---

**Ready to run!** 🚀
