# ============================================
# Faculty Management System - Deployment Status
# ============================================

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "FACULTY MANAGEMENT SYSTEM - DEPLOYMENT STATUS" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ============================================
# 1. GET PODS
# ============================================
Write-Host "1. KUBERNETES PODS STATUS" -ForegroundColor Yellow
Write-Host "Command: kubectl get pods -n faculty-management" -ForegroundColor Gray
Write-Host "--------------------------------------------" -ForegroundColor Gray
kubectl get pods -n faculty-management
Write-Host ""

# ============================================
# 2. GET SERVICES
# ============================================
Write-Host "2. KUBERNETES SERVICES" -ForegroundColor Yellow
Write-Host "Command: kubectl get svc -n faculty-management" -ForegroundColor Gray
Write-Host "--------------------------------------------" -ForegroundColor Gray
kubectl get svc -n faculty-management
Write-Host ""

# ============================================
# 3. GET ALL RESOURCES
# ============================================
Write-Host "3. ALL KUBERNETES RESOURCES" -ForegroundColor Yellow
Write-Host "Command: kubectl get all -n faculty-management" -ForegroundColor Gray
Write-Host "--------------------------------------------" -ForegroundColor Gray
kubectl get all -n faculty-management
Write-Host ""

# ============================================
# 4. GET DEPLOYMENTS
# ============================================
Write-Host "4. DEPLOYMENTS STATUS" -ForegroundColor Yellow
Write-Host "Command: kubectl get deployments -n faculty-management" -ForegroundColor Gray
Write-Host "--------------------------------------------" -ForegroundColor Gray
kubectl get deployments -n faculty-management
Write-Host ""

# ============================================
# 5. GET EXTERNAL IP
# ============================================
Write-Host "5. APPLICATION URL" -ForegroundColor Yellow
Write-Host "--------------------------------------------" -ForegroundColor Gray
$externalIP = kubectl get svc faculty-frontend -n faculty-management -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
if ($externalIP) {
    Write-Host "✅ Application URL: http://$externalIP" -ForegroundColor Green
    Write-Host ""
    Write-Host "Open this URL in your browser to access the application" -ForegroundColor Cyan
} else {
    Write-Host "⚠️  External IP not found or still pending" -ForegroundColor Yellow
}
Write-Host ""

# ============================================
# 6. POD DETAILS
# ============================================
Write-Host "6. DETAILED POD INFORMATION" -ForegroundColor Yellow
Write-Host "Command: kubectl describe pods -n faculty-management" -ForegroundColor Gray
Write-Host "--------------------------------------------" -ForegroundColor Gray
kubectl describe pods -n faculty-management
Write-Host ""

# ============================================
# 7. RECENT LOGS
# ============================================
Write-Host "7. RECENT APPLICATION LOGS" -ForegroundColor Yellow
Write-Host "--------------------------------------------" -ForegroundColor Gray

Write-Host "Frontend Logs (last 10 lines):" -ForegroundColor Cyan
kubectl logs -n faculty-management -l app=faculty-frontend --tail=10
Write-Host ""

Write-Host "Backend Logs (last 10 lines):" -ForegroundColor Cyan
kubectl logs -n faculty-management -l app=faculty-backend --tail=10
Write-Host ""

Write-Host "Database Logs (last 10 lines):" -ForegroundColor Cyan
kubectl logs -n faculty-management -l app=postgres --tail=10
Write-Host ""

# ============================================
# 8. SUMMARY
# ============================================
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "DEPLOYMENT SUMMARY" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan

$pods = kubectl get pods -n faculty-management -o json | ConvertFrom-Json
$runningPods = ($pods.items | Where-Object { $_.status.phase -eq "Running" }).Count
$totalPods = $pods.items.Count

Write-Host "Total Pods: $totalPods" -ForegroundColor White
Write-Host "Running Pods: $runningPods" -ForegroundColor Green
Write-Host ""

if ($runningPods -eq $totalPods) {
    Write-Host "✅ All pods are running successfully!" -ForegroundColor Green
} else {
    Write-Host "⚠️  Some pods are not running" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Application URL: http://$externalIP" -ForegroundColor Cyan
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "SCREENSHOTS READY!" -ForegroundColor Green
Write-Host "Take screenshots of the output above for your submission" -ForegroundColor White
Write-Host "============================================" -ForegroundColor Cyan
