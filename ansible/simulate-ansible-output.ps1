# Simulate Ansible Playbook Execution Output
# This script displays output similar to actual Ansible execution

Clear-Host

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "ANSIBLE PLAYBOOK EXECUTION - Faculty Management System" -ForegroundColor Cyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Command: ansible-playbook playbook.yml" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 500

Write-Host "PLAY [Configure Web Servers] **************************************************" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Gathering Facts] *********************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [webserver1]" -ForegroundColor Green
Write-Host "ok: [webserver2]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Display server information] **********************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [webserver1] => {" -ForegroundColor Green
Write-Host '    "msg": "Configuring webserver1 as web server"' -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host "ok: [webserver2] => {" -ForegroundColor Green
Write-Host '    "msg": "Configuring webserver2 as web server"' -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Update package cache (Debian/Ubuntu)] ************************************" -ForegroundColor White
Start-Sleep -Milliseconds 400
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Docker prerequisites] ********************************************" -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "changed: [webserver1] => (item=apt-transport-https)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=apt-transport-https)" -ForegroundColor Yellow
Write-Host "changed: [webserver1] => (item=ca-certificates)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=ca-certificates)" -ForegroundColor Yellow
Write-Host "changed: [webserver1] => (item=curl)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=curl)" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Add Docker GPG key] ******************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 400
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Docker] **********************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 600
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Start and enable Docker service] *****************************************" -ForegroundColor White
Start-Sleep -Milliseconds 400
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Node.js and npm] *************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "changed: [webserver1] => (item=nodejs)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=nodejs)" -ForegroundColor Yellow
Write-Host "changed: [webserver1] => (item=npm)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=npm)" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Nginx] ***********************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Start and enable Nginx service] ******************************************" -ForegroundColor White
Start-Sleep -Milliseconds 400
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Create application directory] ********************************************" -ForegroundColor White
Start-Sleep -Milliseconds 300
Write-Host "changed: [webserver1]" -ForegroundColor Yellow
Write-Host "changed: [webserver2]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Python packages for Docker management] **************************" -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "changed: [webserver1] => (item=python3-pip)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=python3-pip)" -ForegroundColor Yellow
Write-Host "changed: [webserver1] => (item=python3-docker)" -ForegroundColor Yellow
Write-Host "changed: [webserver2] => (item=python3-docker)" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Display installed software versions] *************************************" -ForegroundColor White
Start-Sleep -Milliseconds 300
Write-Host "ok: [webserver1]" -ForegroundColor Green
Write-Host "ok: [webserver2]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Show software versions] **************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [webserver1] => {" -ForegroundColor Green
Write-Host '    "software_versions.stdout_lines": [' -ForegroundColor White
Write-Host '        "Docker: Docker version 24.0.5, build ced0996",' -ForegroundColor White
Write-Host '        "Node.js: v18.17.1",' -ForegroundColor White
Write-Host '        "npm: 9.6.7",' -ForegroundColor White
Write-Host '        "Nginx: nginx version: nginx/1.18.0 (Ubuntu)"' -ForegroundColor White
Write-Host "    ]" -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host "ok: [webserver2] => {" -ForegroundColor Green
Write-Host '    "software_versions.stdout_lines": [' -ForegroundColor White
Write-Host '        "Docker: Docker version 24.0.5, build ced0996",' -ForegroundColor White
Write-Host '        "Node.js: v18.17.1",' -ForegroundColor White
Write-Host '        "npm: 9.6.7",' -ForegroundColor White
Write-Host '        "Nginx: nginx version: nginx/1.18.0 (Ubuntu)"' -ForegroundColor White
Write-Host "    ]" -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 500

Write-Host "PLAY [Configure Database Servers] **********************************************" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Gathering Facts] *********************************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [dbserver1]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Display server information] **********************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [dbserver1] => {" -ForegroundColor Green
Write-Host '    "msg": "Configuring dbserver1 as database server"' -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Update package cache (Debian/Ubuntu)] ************************************" -ForegroundColor White
Start-Sleep -Milliseconds 300
Write-Host "ok: [dbserver1]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Docker for database containers] **********************************" -ForegroundColor White
Start-Sleep -Milliseconds 400
Write-Host "ok: [dbserver1]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Start and enable Docker service] *****************************************" -ForegroundColor White
Start-Sleep -Milliseconds 300
Write-Host "ok: [dbserver1]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install PostgreSQL client tools] *****************************************" -ForegroundColor White
Start-Sleep -Milliseconds 500
Write-Host "changed: [dbserver1]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Create database data directory] ******************************************" -ForegroundColor White
Start-Sleep -Milliseconds 300
Write-Host "changed: [dbserver1]" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Install Python packages for database management] ************************" -ForegroundColor White
Start-Sleep -Milliseconds 400
Write-Host "changed: [dbserver1] => (item=python3-pip)" -ForegroundColor Yellow
Write-Host "changed: [dbserver1] => (item=python3-psycopg2)" -ForegroundColor Yellow
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Display installed software versions] *************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [dbserver1]" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Show database software versions] *****************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [dbserver1] => {" -ForegroundColor Green
Write-Host '    "db_software_versions.stdout_lines": [' -ForegroundColor White
Write-Host '        "Docker: Docker version 24.0.5, build ced0996",' -ForegroundColor White
Write-Host '        "PostgreSQL Client: psql (PostgreSQL) 14.9"' -ForegroundColor White
Write-Host "    ]" -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 500

Write-Host "PLAY [Post-Configuration Summary] **********************************************" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 300

Write-Host "TASK [Display completion message] **********************************************" -ForegroundColor White
Start-Sleep -Milliseconds 200
Write-Host "ok: [webserver1] => {" -ForegroundColor Green
Write-Host '    "msg": "Configuration completed for webserver1"' -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host "ok: [webserver2] => {" -ForegroundColor Green
Write-Host '    "msg": "Configuration completed for webserver2"' -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host "ok: [dbserver1] => {" -ForegroundColor Green
Write-Host '    "msg": "Configuration completed for dbserver1"' -ForegroundColor White
Write-Host "}" -ForegroundColor Green
Write-Host ""

Start-Sleep -Milliseconds 500

Write-Host "PLAY RECAP *********************************************************************" -ForegroundColor Cyan
Write-Host "webserver1                 : " -NoNewline -ForegroundColor White
Write-Host "ok=14   " -NoNewline -ForegroundColor Green
Write-Host "changed=11   " -NoNewline -ForegroundColor Yellow
Write-Host "unreachable=0    failed=0    " -NoNewline -ForegroundColor White
Write-Host "skipped=0    rescued=0    ignored=0" -ForegroundColor White

Write-Host "webserver2                 : " -NoNewline -ForegroundColor White
Write-Host "ok=14   " -NoNewline -ForegroundColor Green
Write-Host "changed=11   " -NoNewline -ForegroundColor Yellow
Write-Host "unreachable=0    failed=0    " -NoNewline -ForegroundColor White
Write-Host "skipped=0    rescued=0    ignored=0" -ForegroundColor White

Write-Host "dbserver1                  : " -NoNewline -ForegroundColor White
Write-Host "ok=10   " -NoNewline -ForegroundColor Green
Write-Host "changed=3    " -NoNewline -ForegroundColor Yellow
Write-Host "unreachable=0    failed=0    " -NoNewline -ForegroundColor White
Write-Host "skipped=0    rescued=0    ignored=0" -ForegroundColor White

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "ANSIBLE PLAYBOOK EXECUTION COMPLETE" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ All tasks completed successfully!" -ForegroundColor Green
Write-Host "✅ Software installed on all servers" -ForegroundColor Green
Write-Host "✅ Services configured and running" -ForegroundColor Green
Write-Host ""
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
