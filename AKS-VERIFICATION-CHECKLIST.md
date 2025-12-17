# AKS Deployment Verification Checklist

## SECTION C: KUBERNETES ON AZURE (AKS) - 12 Marks

---

## ✅ Task C1: Kubernetes Manifests (6 Marks)

### Requirement 1: Create Azure Kubernetes Cluster (AKS)

**Steps to Complete**:
1. [ ] Install Azure CLI
2. [ ] Login to Azure: `az login`
3. [ ] Create resource group: `az group create --name faculty-management-rg --location eastus`
4. [ ] Create AKS cluster: `az aks create ...` (see AKS-DEPLOYMENT-GUIDE.md)
5. [ ] Get credentials: `az aks get-credentials ...`
6. [ ] Verify connection: `kubectl get nodes`

**Verification Command**:
```powershell
kubectl get nodes
```

**Expected Output**:
```
NAME                                STATUS   ROLES   AGE   VERSION
aks-nodepool1-xxxxx-vmss000000      Ready    agent   10m   v1.27.x
aks-nodepool1-xxxxx-vmss000001      Ready    agent   10m   v1.27.x
```

**Screenshot**: ✅ Take screenshot of nodes showing "Ready" status

---

### Requirement 2: Deploy Containerized Application from Docker Hub

**Prerequisites**:
1. [ ] Push images to Docker Hub
   ```powershell
   docker push YOUR_USERNAME/faculty-backend:latest
   docker push YOUR_USERNAME/faculty-frontend:latest
   ```

2. [ ] Update Kubernetes manifests with your Docker Hub username
   - [ ] Edit `k8s/frontend-deployment.yaml` (line ~20)
   - [ ] Edit `k8s/backend-deployment.yaml` (line ~20)

**Deployment Steps**:
```powershell
# 1. Create namespace
kubectl apply -f k8s/namespace.yaml

# 2. Deploy database
kubectl apply -f k8s/postgres-secret.yaml
kubectl apply -f k8s/postgres-pvc.yaml
kubectl apply -f k8s/postgres-deployment.yaml
kubectl apply -f k8s/postgres-service.yaml

# 3. Deploy backend
kubectl apply -f k8s/backend-configmap.yaml
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml

# 4. Deploy frontend
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
```

**Verification Command**:
```powershell
kubectl get deployments -n faculty-management
```

**Expected Output**:
```
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
faculty-backend    2/2     2            2           5m
faculty-frontend   2/2     2            2           5m
postgres           1/1     1            1           5m
```

**Screenshot**: ✅ Take screenshot of deployments

---

### Requirement 3: Expose App Using Public IP

**Verification Command**:
```powershell
kubectl get service faculty-frontend -n faculty-management
```

**Expected Output**:
```
NAME               TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)      AGE
faculty-frontend   LoadBalancer   10.0.123.45    20.123.45.67     80:30123/TCP 5m
```

**Public URL**: http://EXTERNAL_IP (e.g., http://20.123.45.67)

**Screenshots**:
- ✅ Screenshot of service showing EXTERNAL-IP
- ✅ Screenshot of browser accessing the application
- ✅ Screenshot of login page
- ✅ Screenshot of application working (after login)

---

## ✅ Task C2: AKS Deployment Verification (6 Marks)

### Requirement 1: All Pods in Running State

**Verification Command**:
```powershell
kubectl get pods -n faculty-management
```

**Expected Output**:
```
NAME                                READY   STATUS    RESTARTS   AGE
faculty-backend-xxxxxxxxxx-xxxxx    1/1     Running   0          5m
faculty-backend-xxxxxxxxxx-xxxxx    1/1     Running   0          5m
faculty-frontend-xxxxxxxxxx-xxxxx   1/1     Running   0          5m
faculty-frontend-xxxxxxxxxx-xxxxx   1/1     Running   0          5m
postgres-xxxxxxxxxx-xxxxx           1/1     Running   0          5m
```

**Checklist**:
- [ ] All pods show "Running" status
- [ ] All pods show "1/1" ready
- [ ] No pods in "Error", "CrashLoopBackOff", or "Pending" state
- [ ] 2 backend pods running
- [ ] 2 frontend pods running
- [ ] 1 postgres pod running

**Screenshot**: ✅ Take screenshot showing all pods running

**Detailed Verification**:
```powershell
kubectl describe pods -n faculty-management
```

**Screenshot**: ✅ Take screenshot of pod details

---

### Requirement 2: Services Created Successfully

**Verification Command**:
```powershell
kubectl get services -n faculty-management
```

**Expected Output**:
```
NAME               TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
faculty-backend    ClusterIP      10.0.123.45    <none>           5000/TCP       5m
faculty-frontend   LoadBalancer   10.0.123.46    20.123.45.67     80:30123/TCP   5m
postgres           ClusterIP      10.0.123.47    <none>           5432/TCP       5m
```

**Checklist**:
- [ ] `faculty-backend` service exists (ClusterIP)
- [ ] `faculty-frontend` service exists (LoadBalancer)
- [ ] `postgres` service exists (ClusterIP)
- [ ] `faculty-frontend` has EXTERNAL-IP assigned
- [ ] All services have correct ports

**Screenshot**: ✅ Take screenshot of services

---

### Requirement 3: Frontend Connecting to Backend

**Test Method 1: Browser Test**
1. [ ] Open browser
2. [ ] Go to: http://EXTERNAL_IP
3. [ ] Register a new user
4. [ ] Login successfully
5. [ ] Navigate to "Add Faculty" page
6. [ ] Add a faculty member
7. [ ] View faculty list

**Screenshot**: ✅ Take screenshots of:
- Login page
- Dashboard after login
- Add faculty form
- Faculty list showing data

**Test Method 2: Network Test**
```powershell
# Get frontend pod name
kubectl get pods -n faculty-management | findstr frontend

# Check frontend logs for backend API calls
kubectl logs FRONTEND_POD_NAME -n faculty-management
```

**Expected in Logs**: Should show successful compilation, no connection errors

**Test Method 3: Port Forward Test**
```powershell
# Port forward frontend
kubectl port-forward -n faculty-management service/faculty-frontend 3000:80
```

Open browser: http://localhost:3000
- [ ] Page loads successfully
- [ ] Can interact with application

**Screenshot**: ✅ Take screenshot of working application

---

### Requirement 4: Backend Connecting to Database

**Test Method 1: Check Backend Logs**
```powershell
# Get backend pod name
kubectl get pods -n faculty-management | findstr backend

# Check logs
kubectl logs BACKEND_POD_NAME -n faculty-management
```

**Expected Output**:
```
Database initialized successfully
Server running on http://localhost:5000
```

**Checklist**:
- [ ] Logs show "Database initialized successfully"
- [ ] Logs show "Server running"
- [ ] No database connection errors

**Screenshot**: ✅ Take screenshot of backend logs

**Test Method 2: Direct Database Connection**
```powershell
# Get postgres pod name
kubectl get pods -n faculty-management | findstr postgres

# Connect to database
kubectl exec -it POSTGRES_POD_NAME -n faculty-management -- psql -U postgres -d faculty_db

# Inside postgres, run:
\dt

# Expected: Should show tables: users, faculty

# Check if tables have data:
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM faculty;

# Exit:
\q
```

**Checklist**:
- [ ] Can connect to database
- [ ] Tables exist (users, faculty)
- [ ] Can query tables

**Screenshot**: ✅ Take screenshot of database connection and tables

**Test Method 3: API Test**
```powershell
# Port forward backend
kubectl port-forward -n faculty-management service/faculty-backend 5000:5000
```

In another PowerShell window:
```powershell
# Test backend is responding
curl http://localhost:5000/api/stats
```

**Expected**: Should return JSON response (even if error about token, it means backend is working)

**Screenshot**: ✅ Take screenshot of API response

---

## 📊 COMPLETE VERIFICATION SUMMARY

### Run All Verification Commands

```powershell
# 1. Cluster info
kubectl cluster-info

# 2. Nodes
kubectl get nodes

# 3. All resources
kubectl get all -n faculty-management

# 4. Pods with details
kubectl get pods -n faculty-management -o wide

# 5. Services
kubectl get services -n faculty-management

# 6. Deployments
kubectl get deployments -n faculty-management

# 7. Persistent volumes
kubectl get pvc -n faculty-management

# 8. ConfigMaps and Secrets
kubectl get configmaps,secrets -n faculty-management

# 9. Events (check for errors)
kubectl get events -n faculty-management --sort-by='.lastTimestamp'

# 10. Resource usage
kubectl top nodes
kubectl top pods -n faculty-management
```

---

## 📸 REQUIRED SCREENSHOTS FOR SUBMISSION

### Azure Portal Screenshots
1. [ ] AKS cluster overview page
2. [ ] Resource group showing all resources
3. [ ] AKS nodes page

### Kubernetes Screenshots
4. [ ] `kubectl get nodes` output
5. [ ] `kubectl get pods -n faculty-management` output
6. [ ] `kubectl get services -n faculty-management` output
7. [ ] `kubectl get deployments -n faculty-management` output
8. [ ] `kubectl get all -n faculty-management` output
9. [ ] `kubectl describe pods -n faculty-management` output

### Application Screenshots
10. [ ] Browser showing application at http://EXTERNAL_IP
11. [ ] Login page
12. [ ] Registration page
13. [ ] Dashboard after login
14. [ ] Add faculty page
15. [ ] Faculty list with data

### Connectivity Screenshots
16. [ ] Backend logs showing database connection
17. [ ] Database connection showing tables
18. [ ] Frontend successfully loading data from backend

---

## ✅ FINAL CHECKLIST

### Task C1: Kubernetes Manifests (6 Marks)
- [ ] AKS cluster created and running
- [ ] Application deployed from Docker Hub
- [ ] Public IP assigned and accessible
- [ ] Application reachable via browser

### Task C2: AKS Deployment Verification (6 Marks)
- [ ] All pods in Running state (5 pods total)
- [ ] All services created successfully (3 services)
- [ ] Frontend connects to backend (verified via browser)
- [ ] Backend connects to database (verified via logs)

### Documentation
- [ ] All screenshots taken
- [ ] Public URL documented
- [ ] Verification commands documented

---

## 🎯 GRADING EVIDENCE

**Public URL**: http://YOUR_EXTERNAL_IP

**Cluster Details**:
- Resource Group: faculty-management-rg
- Cluster Name: faculty-aks-cluster
- Location: eastus
- Node Count: 2
- Node Size: Standard_B2s

**Deployed Components**:
- Frontend: 2 replicas (LoadBalancer)
- Backend: 2 replicas (ClusterIP)
- Database: 1 replica (ClusterIP)
- Persistent Volume: 5Gi for PostgreSQL

**All Requirements**: ✅ SATISFIED

---

**Ready for Submission!** 🚀
