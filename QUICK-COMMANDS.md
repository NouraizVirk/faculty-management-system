# 🚀 Quick Commands for Screenshots

## For Windows (PowerShell)

### Run the Status Script:
```powershell
.\get-deployment-status.ps1
```

### Individual Commands:

#### 1. Get Pods
```powershell
kubectl get pods -n faculty-management
```

#### 2. Get Services
```powershell
kubectl get svc -n faculty-management
```

#### 3. Get All Resources
```powershell
kubectl get all -n faculty-management
```

#### 4. Get Deployments
```powershell
kubectl get deployments -n faculty-management
```

#### 5. Get External IP
```powershell
kubectl get svc faculty-frontend -n faculty-management -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

#### 6. Check Pod Logs
```powershell
# Frontend logs
kubectl logs -n faculty-management -l app=faculty-frontend --tail=20

# Backend logs
kubectl logs -n faculty-management -l app=faculty-backend --tail=20

# Database logs
kubectl logs -n faculty-management -l app=postgres --tail=20
```

---

## For Linux/Mac (Bash)

### Run the Status Script:
```bash
chmod +x get-deployment-status.sh
./get-deployment-status.sh
```

### Individual Commands:
Same as Windows commands above (without PowerShell syntax)

---

## 📸 Screenshots Needed for Section C (Kubernetes)

### Screenshot 1: Pods Status
```powershell
kubectl get pods -n faculty-management
```
**Shows**: All 3 pods (frontend, backend, postgres) in Running state

### Screenshot 2: Services
```powershell
kubectl get svc -n faculty-management
```
**Shows**: LoadBalancer with external IP, ClusterIP services

### Screenshot 3: All Resources
```powershell
kubectl get all -n faculty-management
```
**Shows**: Pods, services, deployments, replicasets

### Screenshot 4: Deployments
```powershell
kubectl get deployments -n faculty-management
```
**Shows**: All deployments ready (1/1)

### Screenshot 5: Application in Browser
**URL**: http://135.171.156.197
**Shows**: 
- Login page
- Dashboard after login
- Add faculty page
- Faculty list

### Screenshot 6: Pod Details
```powershell
kubectl describe pods -n faculty-management
```
**Shows**: Detailed pod information, events, status

### Screenshot 7: Azure Portal
- Navigate to: https://portal.azure.com
- Resource Groups → faculty-management-rg
- Show: AKS cluster overview

---

## 🎯 Quick Verification Commands

### Check if everything is running:
```powershell
kubectl get all -n faculty-management
```

### Get application URL:
```powershell
kubectl get svc faculty-frontend -n faculty-management
```
Look for EXTERNAL-IP column

### Check pod health:
```powershell
kubectl get pods -n faculty-management -o wide
```

### View recent events:
```powershell
kubectl get events -n faculty-management --sort-by='.lastTimestamp'
```

---

## 🔧 Troubleshooting Commands

### If pods are not running:
```powershell
kubectl describe pod <pod-name> -n faculty-management
```

### Check logs for errors:
```powershell
kubectl logs <pod-name> -n faculty-management
```

### Restart a deployment:
```powershell
kubectl rollout restart deployment/<deployment-name> -n faculty-management
```

### Check service endpoints:
```powershell
kubectl get endpoints -n faculty-management
```

---

## 📊 For CI/CD Pipeline Screenshots (Section B)

### View GitHub Actions:
1. Go to: https://github.com/NouraizVirk/faculty-management-system/actions
2. Click on latest workflow run
3. Take screenshots of:
   - Workflow overview (all jobs)
   - Build job details
   - Test job details
   - Docker job details
   - Deployment job details

---

## 🎓 Application URL

**Live Application**: http://135.171.156.197

### Test the application:
1. Open URL in browser
2. Click "Register" to create account
3. Login with credentials
4. Add a faculty member
5. View faculty list
6. Take screenshots of each page

---

## 💾 Save Output to File

### PowerShell:
```powershell
.\get-deployment-status.ps1 | Out-File -FilePath deployment-status.txt
```

### Bash:
```bash
./get-deployment-status.sh > deployment-status.txt
```

---

## ✅ Checklist for Screenshots

- [ ] kubectl get pods output
- [ ] kubectl get svc output
- [ ] kubectl get all output
- [ ] kubectl get deployments output
- [ ] Application homepage
- [ ] Login page
- [ ] Dashboard
- [ ] Add faculty page
- [ ] Faculty list
- [ ] GitHub Actions pipeline
- [ ] Azure Portal - AKS cluster
- [ ] Docker Hub images

---

**Ready to take screenshots!** 📸
