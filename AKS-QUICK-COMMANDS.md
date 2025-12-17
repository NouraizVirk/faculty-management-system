# AKS Quick Reference Commands

## 🚀 QUICK DEPLOYMENT (Copy-Paste Ready)

### 1. Login to Azure
```powershell
az login
```

### 2. Create Resource Group
```powershell
az group create --name faculty-management-rg --location eastus
```

### 3. Create AKS Cluster (⏱️ Takes 5-10 minutes)
```powershell
az aks create `
  --resource-group faculty-management-rg `
  --name faculty-aks-cluster `
  --node-count 2 `
  --node-vm-size Standard_B2s `
  --enable-addons monitoring `
  --generate-ssh-keys `
  --network-plugin azure
```

### 4. Get Credentials
```powershell
az aks get-credentials --resource-group faculty-management-rg --name faculty-aks-cluster
```

### 5. Deploy Everything
```powershell
# Navigate to project directory first!
cd "E:\University stuff\Semester 7\DevOps\DevOps Final\Faculty managment system"

# Deploy in order
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/postgres-secret.yaml
kubectl apply -f k8s/postgres-pvc.yaml
kubectl apply -f k8s/postgres-deployment.yaml
kubectl apply -f k8s/postgres-service.yaml
kubectl apply -f k8s/backend-configmap.yaml
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
```

### 6. Get Public IP
```powershell
kubectl get service faculty-frontend -n faculty-management
```

---

## 📊 MONITORING COMMANDS

### Check Everything
```powershell
kubectl get all -n faculty-management
```

### Check Pods
```powershell
kubectl get pods -n faculty-management
```

### Check Services
```powershell
kubectl get services -n faculty-management
```

### Watch Pods (Real-time)
```powershell
kubectl get pods -n faculty-management -w
```

### Check Pod Logs
```powershell
# List pods first
kubectl get pods -n faculty-management

# View logs (replace POD_NAME)
kubectl logs POD_NAME -n faculty-management

# Follow logs (real-time)
kubectl logs -f POD_NAME -n faculty-management
```

### Describe Pod (Detailed Info)
```powershell
kubectl describe pod POD_NAME -n faculty-management
```

### Check Events
```powershell
kubectl get events -n faculty-management --sort-by='.lastTimestamp'
```

---

## 🔧 TROUBLESHOOTING COMMANDS

### Restart a Deployment
```powershell
kubectl rollout restart deployment/faculty-backend -n faculty-management
kubectl rollout restart deployment/faculty-frontend -n faculty-management
```

### Delete and Recreate a Pod
```powershell
kubectl delete pod POD_NAME -n faculty-management
```

### Check Resource Usage
```powershell
kubectl top nodes
kubectl top pods -n faculty-management
```

### Access Pod Shell
```powershell
kubectl exec -it POD_NAME -n faculty-management -- /bin/sh
```

### Port Forward (Test Locally)
```powershell
# Backend
kubectl port-forward -n faculty-management service/faculty-backend 5000:5000

# Frontend
kubectl port-forward -n faculty-management service/faculty-frontend 3000:80

# Database
kubectl port-forward -n faculty-management service/postgres 5432:5432
```

---

## 🗑️ CLEANUP COMMANDS

### Delete All Resources
```powershell
kubectl delete namespace faculty-management
```

### Delete AKS Cluster
```powershell
az aks delete --resource-group faculty-management-rg --name faculty-aks-cluster --yes --no-wait
```

### Delete Resource Group (Everything)
```powershell
az group delete --name faculty-management-rg --yes --no-wait
```

---

## 📸 SCREENSHOT COMMANDS

### For Grading - Run These
```powershell
# 1. Show all pods
kubectl get pods -n faculty-management

# 2. Show all services
kubectl get services -n faculty-management

# 3. Show all deployments
kubectl get deployments -n faculty-management

# 4. Show detailed pod info
kubectl describe pods -n faculty-management

# 5. Show nodes
kubectl get nodes

# 6. Show everything
kubectl get all -n faculty-management
```

---

## 🔍 VERIFICATION COMMANDS

### Test Backend Connection
```powershell
kubectl port-forward -n faculty-management service/faculty-backend 5000:5000
# Then in another window:
curl http://localhost:5000/api/stats
```

### Test Database Connection
```powershell
# Get postgres pod name
kubectl get pods -n faculty-management | findstr postgres

# Connect to database
kubectl exec -it POSTGRES_POD_NAME -n faculty-management -- psql -U postgres -d faculty_db

# Inside postgres:
\dt          # List tables
\q           # Quit
```

### Check Logs for Errors
```powershell
# Backend logs
kubectl logs -l app=faculty-backend -n faculty-management --tail=50

# Frontend logs
kubectl logs -l app=faculty-frontend -n faculty-management --tail=50

# Database logs
kubectl logs -l app=postgres -n faculty-management --tail=50
```

---

## 💡 USEFUL TIPS

### Get External IP (Keep Checking)
```powershell
# Run this every 30 seconds until you see an IP
kubectl get service faculty-frontend -n faculty-management -w
```

### Check if Pods are Ready
```powershell
kubectl wait --for=condition=ready pod -l app=faculty-backend -n faculty-management --timeout=300s
```

### View All Resources
```powershell
kubectl api-resources
```

### Get YAML of Running Resource
```powershell
kubectl get deployment faculty-backend -n faculty-management -o yaml
```

---

## 🎯 GRADING CHECKLIST COMMANDS

Run these for your submission:

```powershell
# 1. Show cluster info
kubectl cluster-info

# 2. Show nodes
kubectl get nodes

# 3. Show all resources in namespace
kubectl get all -n faculty-management

# 4. Show pods with details
kubectl get pods -n faculty-management -o wide

# 5. Show services with external IP
kubectl get services -n faculty-management

# 6. Show deployments
kubectl get deployments -n faculty-management

# 7. Show persistent volumes
kubectl get pvc -n faculty-management

# 8. Show secrets and configmaps
kubectl get secrets,configmaps -n faculty-management
```

---

## 📱 QUICK STATUS CHECK

```powershell
# One command to check everything
kubectl get pods,services,deployments,pvc -n faculty-management
```

**Expected Output**:
- 5 pods (2 backend, 2 frontend, 1 postgres) - all Running
- 3 services (backend, frontend, postgres)
- 3 deployments (backend, frontend, postgres)
- 1 pvc (postgres-pvc) - Bound

---

## 🆘 EMERGENCY COMMANDS

### If Everything is Broken
```powershell
# Delete everything and start over
kubectl delete namespace faculty-management

# Wait 30 seconds, then redeploy
kubectl apply -f k8s/
```

### If Cluster is Broken
```powershell
# Delete and recreate cluster
az aks delete --resource-group faculty-management-rg --name faculty-aks-cluster --yes
az aks create --resource-group faculty-management-rg --name faculty-aks-cluster --node-count 2 --node-vm-size Standard_B2s --generate-ssh-keys
az aks get-credentials --resource-group faculty-management-rg --name faculty-aks-cluster
```

---

**Save this file for quick reference!** 📌
