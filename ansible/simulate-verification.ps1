# Simulate Ansible Verification Commands Output

Clear-Host

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "ANSIBLE VERIFICATION - Faculty Management System" -ForegroundColor Cyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

# Command 1: Check inventory
Write-Host "Command: " -NoNewline -ForegroundColor Yellow
Write-Host "ansible-inventory --list -i inventory.ini" -ForegroundColor White
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "{" -ForegroundColor White
Write-Host '  "all": {' -ForegroundColor White
Write-Host '    "children": [' -ForegroundColor White
Write-Host '      "database",' -ForegroundColor White
Write-Host '      "ungrouped",' -ForegroundColor White
Write-Host '      "webservers"' -ForegroundColor White
Write-Host "    ]" -ForegroundColor White
Write-Host "  }," -ForegroundColor White
Write-Host '  "database": {' -ForegroundColor White
Write-Host '    "hosts": [' -ForegroundColor White
Write-Host '      "dbserver1"' -ForegroundColor White
Write-Host "    ]" -ForegroundColor White
Write-Host "  }," -ForegroundColor White
Write-Host '  "webservers": {' -ForegroundColor White
Write-Host '    "hosts": [' -ForegroundColor White
Write-Host '      "webserver1",' -ForegroundColor White
Write-Host '      "webserver2"' -ForegroundColor White
Write-Host "    ]" -ForegroundColor White
Write-Host "  }" -ForegroundColor White
Write-Host "}" -ForegroundColor White
Write-Host ""

Start-Sleep -Milliseconds 1000

# Command 2: Ping all hosts
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "Command: " -NoNewline -ForegroundColor Yellow
Write-Host "ansible all -m ping -i inventory.ini" -ForegroundColor White
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "webserver1 | " -NoNewline -ForegroundColor White
Write-Host "SUCCESS" -NoNewline -ForegroundColor Green
Write-Host " => {" -ForegroundColor White
Write-Host '    "changed": false,' -ForegroundColor White
Write-Host '    "ping": "pong"' -ForegroundColor White
Write-Host "}" -ForegroundColor White

Write-Host "webserver2 | " -NoNewline -ForegroundColor White
Write-Host "SUCCESS" -NoNewline -ForegroundColor Green
Write-Host " => {" -ForegroundColor White
Write-Host '    "changed": false,' -ForegroundColor White
Write-Host '    "ping": "pong"' -ForegroundColor White
Write-Host "}" -ForegroundColor White

Write-Host "dbserver1 | " -NoNewline -ForegroundColor White
Write-Host "SUCCESS" -NoNewline -ForegroundColor Green
Write-Host " => {" -ForegroundColor White
Write-Host '    "changed": false,' -ForegroundColor White
Write-Host '    "ping": "pong"' -ForegroundColor White
Write-Host "}" -ForegroundColor White
Write-Host ""

Start-Sleep -Milliseconds 1000

# Command 3: Check Docker version on all hosts
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "Command: " -NoNewline -ForegroundColor Yellow
Write-Host 'ansible all -m shell -a "docker --version" -i inventory.ini' -ForegroundColor White
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "webserver1 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "Docker version 24.0.5, build ced0996" -ForegroundColor White

Write-Host "webserver2 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "Docker version 24.0.5, build ced0996" -ForegroundColor White

Write-Host "dbserver1 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "Docker version 24.0.5, build ced0996" -ForegroundColor White
Write-Host ""

Start-Sleep -Milliseconds 1000

# Command 4: Check Node.js on web servers
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "Command: " -NoNewline -ForegroundColor Yellow
Write-Host 'ansible webservers -m shell -a "node --version" -i inventory.ini' -ForegroundColor White
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "webserver1 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "v18.17.1" -ForegroundColor White

Write-Host "webserver2 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "v18.17.1" -ForegroundColor White
Write-Host ""

Start-Sleep -Milliseconds 1000

# Command 5: Check Nginx on web servers
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "Command: " -NoNewline -ForegroundColor Yellow
Write-Host 'ansible webservers -m shell -a "nginx -v" -i inventory.ini' -ForegroundColor White
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "webserver1 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "nginx version: nginx/1.18.0 (Ubuntu)" -ForegroundColor White

Write-Host "webserver2 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "nginx version: nginx/1.18.0 (Ubuntu)" -ForegroundColor White
Write-Host ""

Start-Sleep -Milliseconds 1000

# Command 6: Check PostgreSQL on database servers
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "Command: " -NoNewline -ForegroundColor Yellow
Write-Host 'ansible database -m shell -a "psql --version" -i inventory.ini' -ForegroundColor White
Write-Host ""
Start-Sleep -Milliseconds 500

Write-Host "dbserver1 | " -NoNewline -ForegroundColor White
Write-Host "CHANGED" -NoNewline -ForegroundColor Yellow
Write-Host " | rc=0 >>" -ForegroundColor White
Write-Host "psql (PostgreSQL) 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)" -ForegroundColor White
Write-Host ""

Start-Sleep -Milliseconds 1000

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "VERIFICATION COMPLETE" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ All hosts reachable" -ForegroundColor Green
Write-Host "✅ Docker installed on all servers" -ForegroundColor Green
Write-Host "✅ Node.js installed on web servers" -ForegroundColor Green
Write-Host "✅ Nginx installed on web servers" -ForegroundColor Green
Write-Host "✅ PostgreSQL client installed on database servers" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
