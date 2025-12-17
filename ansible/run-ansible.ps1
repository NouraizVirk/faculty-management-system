# PowerShell script to run Ansible (requires WSL)

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Faculty Management System - Ansible Setup" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Check if WSL is available
try {
    wsl --version | Out-Null
    Write-Host "✅ WSL is available" -ForegroundColor Green
} catch {
    Write-Host "❌ WSL is not installed!" -ForegroundColor Red
    Write-Host "Install WSL first: wsl --install" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "🚀 Running Ansible in WSL..." -ForegroundColor Yellow
Write-Host ""

# Run Ansible in WSL
wsl bash -c "cd /mnt/e/'University stuff'/'Semester 7'/DevOps/'DevOps Final'/'Faculty managment system'/ansible && chmod +x run-ansible.sh && ./run-ansible.sh"

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "✅ Execution complete!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
