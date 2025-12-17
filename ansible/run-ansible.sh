#!/bin/bash
# Quick execution script for Ansible playbooks

echo "========================================="
echo "Faculty Management System - Ansible Setup"
echo "========================================="
echo ""

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "❌ Ansible is not installed!"
    echo "Install with: sudo apt install ansible -y"
    exit 1
fi

echo "✅ Ansible version:"
ansible --version | head -n 1
echo ""

# Test connectivity
echo "📡 Testing connectivity to hosts..."
ansible all -m ping -i inventory.ini
echo ""

# Run playbook
echo "🚀 Running Ansible playbook..."
echo ""
ansible-playbook playbook.yml -i inventory.ini

echo ""
echo "========================================="
echo "✅ Ansible execution complete!"
echo "========================================="
echo ""

# Verify installations
echo "🔍 Verifying installations..."
echo ""
echo "Docker versions:"
ansible all -m shell -a "docker --version 2>/dev/null || echo 'Not installed'" -i inventory.ini
echo ""
echo "Node.js versions (web servers):"
ansible webservers -m shell -a "node --version 2>/dev/null || echo 'Not installed'" -i inventory.ini
echo ""
echo "PostgreSQL client (database servers):"
ansible database -m shell -a "psql --version 2>/dev/null || echo 'Not installed'" -i inventory.ini
echo ""
