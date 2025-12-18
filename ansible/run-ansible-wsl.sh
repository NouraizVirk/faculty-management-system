#!/bin/bash

# Ansible Execution Script for WSL
# Run this script in WSL to execute Ansible playbook

echo "================================================================================"
echo "ANSIBLE PLAYBOOK EXECUTION - Faculty Management System"
echo "================================================================================"
echo ""

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "⚠️  Ansible not found. Installing..."
    sudo apt update
    sudo apt install ansible -y
    echo "✅ Ansible installed"
else
    echo "✅ Ansible is already installed"
    ansible --version
fi

echo ""
echo "================================================================================"
echo "STEP 1: Checking Inventory"
echo "================================================================================"
echo ""

cat inventory.ini

echo ""
echo "================================================================================"
echo "STEP 2: Testing Connectivity"
echo "================================================================================"
echo ""

ansible all -m ping -i inventory.ini

echo ""
echo "================================================================================"
echo "STEP 3: Running Playbook"
echo "================================================================================"
echo ""

ansible-playbook playbook.yml

echo ""
echo "================================================================================"
echo "STEP 4: Verification"
echo "================================================================================"
echo ""

echo "Checking Docker on all hosts:"
ansible all -m shell -a "docker --version" -i inventory.ini

echo ""
echo "Checking Node.js on web servers:"
ansible webservers -m shell -a "node --version" -i inventory.ini

echo ""
echo "Checking Nginx on web servers:"
ansible webservers -m shell -a "nginx -v" -i inventory.ini

echo ""
echo "Checking PostgreSQL on database servers:"
ansible database -m shell -a "psql --version" -i inventory.ini

echo ""
echo "================================================================================"
echo "ANSIBLE EXECUTION COMPLETE"
echo "================================================================================"
echo ""
echo "✅ All tasks completed!"
echo "✅ Take screenshots of the output above for your submission"
echo ""
