# Azure Kubernetes Service (AKS) Deployment Guide
## Complete Step-by-Step Instructions for Beginners

---

## 📋 PREREQUISITES

Before starting, ensure you have:
- ✅ Azure account (free tier works: https://azure.microsoft.com/free/)
- ✅ Docker Hub account with your images pushed
- ✅ Windows PowerShell or Command Prompt

---

## PART 1: INSTALL REQUIRED TOOLS

### Step 1.1: Install Azure CLI

1. **Download Azure CLI**:
   - Go to: https://aka.ms/installazurecliwindows
   - Download the MSI installer
   - Run the installer
   - Click "Next" through all prompts
   - Click "Install"
   - Wait for installation to complete
   - Click "Finish"

2. **Verify Installation**:
   ```powershell
   # Open NEW PowerShell window (important!)
   az --version
   ```
   **Expected Output**: Should show version like `azure-cli 2.x.x`

### Step 1.2: Install kubectl (Kubernetes CLI)

1. **Install kubectl using Azure CLI**:
   ```powershell
   az aks install-cli
   ```

2. **Verify Installation**:
   ```powershell
   kubectl version --client
   ```
   **Expected Output**: Should show client version

---

## PART 2: PUSH DOCKER IMAGES TO DOCKER HUB

### Step 2.1: Login to Docker Hub

```powershell
docker login
```
- Enter your Docker Hub username
- Enter your Docker Hub password

### Step 2.2: Tag and Push Images

**IMPORTANT**: Replace `YOUR_DOCKERHUB_USERNAME` with your actual Docker Hub username!

```powershell
# Tag backend image
docker tag facultymanagmentsystem-backend:latest YOUR_DOCKERHUB_USERNAME/faculty-backend:latest

# Tag frontend image
docker tag facultymanagmentsystem-frontend:latest YOUR_DOCKERHUB_USERNAME/faculty-frontend:latest

# Push backend image
docker push YOUR_DOCKERHUB_USERNAME/faculty-backend:latest

# Push frontend image
docker push YOUR_DOCKERHUB_USERNAME/faculty-frontend:latest
```

**Wait for uploads to complete** (may take 5-10 minutes depending on internet speed)

### Step 2.3: Verify Images on Docker Hub

1. Go to: https://hub.docker.com
2. Login to your account
3. You should see:
   - `faculty-backend` repository
   - `faculty-frontend` repository

---

## PART 3: UPDATE KUBERNETES MANIFESTS

### Step 3.1: Update Image Names

You need to update the Kubernetes deployment files with your Docker Hub username.

**File 1: `k8s/frontend-deployment.yaml`**

Find this line (around line 20):
```yaml
image: YOUR_DOCKERHUB_USERNAME/faculty-frontend:latest
```

Replace `YOUR_DOCKERHUB_USERNAME` with your actual username. For example:
```yaml
image: johnsmith/faculty-frontend:latest
```

**File 2: `k8s/backend-deployment.yaml`**

Find this line (around line 20):
```yaml
image: YOUR_DOCKERHUB_USERNAME/faculty-backend:latest
```

Replace `YOUR_DOCKERHUB_USERNAME` with your actual username. For example:
```yaml
image: johnsmith/faculty-backend:latest
```

---

## PART 4: CREATE AZURE KUBERNETES CLUSTER (AKS)

### Step 4.1: Login to Azure

```powershell
az login
```

**What happens**:
- A browser window will open
- Login with your Azure account
- After successful login, close the browser
- Return to PowerShell

**Expected Output**: Should show your subscription details in JSON format

### Step 4.2: Set Your Subscription (if you have multiple)

```powershell
# List all subscriptions
az account list --output table

# Set the subscription you want to use (if needed)
az account set --subscription "YOUR_SUBSCRIPTION_NAME_OR_ID"
```

### Step 4.3: Create Resource Group

```powershell
az group create --name faculty-management-rg --location eastus
```

**What this does**: Creates a container for all your Azure resources

**Expected Output**:
```json
{
  "id": "/subscriptions/.../resourceGroups/faculty-management-rg",
  "location": "eastus",
  "name": "faculty-management-rg",
  "properties": {
    "provisioningState": "Succeeded"
  }
}
```

### Step 4.4: Create AKS Cluster

**⚠️ IMPORTANT**: This step takes 5-10 minutes!

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

**What this does**:
- Creates a Kubernetes cluster named `faculty-aks-cluster`
- With 2 nodes (virtual machines)
- Using small VM size (cost-effective)
- Enables monitoring
- Generates SSH keys automatically

**Expected Output**: Long JSON output ending with `"provisioningState": "Succeeded"`

**☕ Take a break! This takes 5-10 minutes.**

### Step 4.5: Get AKS Credentials

```powershell
az aks get-credentials --resource-group faculty-management-rg --name faculty-aks-cluster
```

**What this does**: Downloads cluster configuration to your local machine

**Expected Output**:
```
Merged "faculty-aks-cluster" as current context in C:\Users\YourName\.kube\config
```

### Step 4.6: Verify Cluster Connection

```powershell
kubectl get nodes
```

**Expected Output**:
```
NAME                                STATUS   ROLES   AGE   VERSION
aks-nodepool1-12345678-vmss000000   Ready    agent   5m    v1.27.x
aks-nodepool1-12345678-vmss000001   Ready    agent   5m    v1.27.x
```

**✅ If you see 2 nodes with STATUS "Ready", you're good to go!**

---

## PART 5: DEPLOY APPLICATION TO AKS

### Step 5.1: Navigate to Project Directory

```powershell
cd "E:\University stuff\Semester 7\DevOps\DevOps Final\Faculty managment system"
```

### Step 5.2: Create Namespace

```powershell
kubectl apply -f k8s/namespace.yaml
```

**Expected Output**: `namespace/faculty-management created`

### Step 5.3: Deploy Database Layer

```powershell
# Create secrets
kubectl apply -f k8s/postgres-secret.yaml

# Create persistent volume claim
kubectl apply -f k8s/postgres-pvc.yaml

# Deploy PostgreSQL
kubectl apply -f k8s/postgres-deployment.yaml

# Create PostgreSQL service
kubectl apply -f k8s/postgres-service.yaml
```

**Expected Output**:
```
secret/postgres-secret created
persistentvolumeclaim/postgres-pvc created
deployment.apps/postgres created
service/postgres created
```

### Step 5.4: Wait for Database to be Ready

```powershell
kubectl get pods -n faculty-management -w
```

**Wait until you see**:
```
NAME                        READY   STATUS    RESTARTS   AGE
postgres-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
```

**Press Ctrl+C to stop watching**

### Step 5.5: Deploy Backend Layer

```powershell
# Create config map
kubectl apply -f k8s/backend-configmap.yaml

# Deploy backend
kubectl apply -f k8s/backend-deployment.yaml

# Create backend service
kubectl apply -f k8s/backend-service.yaml
```

**Expected Output**:
```
configmap/backend-config created
deployment.apps/faculty-backend created
service/faculty-backend created
```

### Step 5.6: Deploy Frontend Layer

```powershell
# Deploy frontend
kubectl apply -f k8s/frontend-deployment.yaml

# Create frontend service (LoadBalancer)
kubectl apply -f k8s/frontend-service.yaml
```

**Expected Output**:
```
deployment.apps/faculty-frontend created
service/faculty-frontend created
```

---

## PART 6: VERIFY DEPLOYMENT

### Step 6.1: Check All Pods are Running

```powershell
kubectl get pods -n faculty-management
```

**Expected Output** (wait 2-3 minutes if not ready):
```
NAME                                READY   STATUS    RESTARTS   AGE
faculty-backend-xxxxxxxxxx-xxxxx    1/1     Running   0          3m
faculty-backend-xxxxxxxxxx-xxxxx    1/1     Running   0          3m
faculty-frontend-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
faculty-frontend-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
postgres-xxxxxxxxxx-xxxxx           1/1     Running   0          5m
```

**✅ All pods should show "Running" status and "1/1" ready**

### Step 6.2: Check Services

```powershell
kubectl get services -n faculty-management
```

**Expected Output**:
```
NAME               TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
faculty-backend    ClusterIP      10.0.123.45    <none>           5000/TCP       3m
faculty-frontend   LoadBalancer   10.0.123.46    20.123.45.67     80:30123/TCP   2m
postgres           ClusterIP      10.0.123.47    <none>           5432/TCP       5m
```

**⚠️ IMPORTANT**: The `faculty-frontend` EXTERNAL-IP might show `<pending>` initially. Wait 2-3 minutes.

### Step 6.3: Get Public IP Address

```powershell
kubectl get service faculty-frontend -n faculty-management
```

**Keep running this command every 30 seconds until you see an EXTERNAL-IP**

**Expected Output**:
```
NAME               TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)      AGE
faculty-frontend   LoadBalancer   10.0.123.46    20.123.45.67     80:30123/TCP 5m
```

**✅ Copy the EXTERNAL-IP (e.g., 20.123.45.67)**

### Step 6.4: Access Your Application

1. **Open your browser**
2. **Go to**: `http://YOUR_EXTERNAL_IP` (e.g., http://20.123.45.67)
3. **You should see the Faculty Management System login page!**

---

## PART 7: VERIFY CONNECTIVITY (FOR GRADING)

### Step 7.1: Check Pod Logs

**Check Backend Logs**:
```powershell
# Get backend pod name
kubectl get pods -n faculty-management | findstr backend

# View logs (replace POD_NAME with actual name)
kubectl logs POD_NAME -n faculty-management
```

**Expected**: Should show "Database initialized successfully" and "Server running"

**Check Frontend Logs**:
```powershell
# Get frontend pod name
kubectl get pods -n faculty-management | findstr frontend

# View logs (replace POD_NAME with actual name)
kubectl logs POD_NAME -n faculty-management
```

### Step 7.2: Test Backend Connection

```powershell
# Port forward backend to test locally
kubectl port-forward -n faculty-management service/faculty-backend 5000:5000
```

**Open another PowerShell window and test**:
```powershell
curl http://localhost:5000/api/stats
```

**Expected**: Should return JSON (might show error about no token, that's OK)

**Press Ctrl+C in first window to stop port forwarding**

### Step 7.3: Test Database Connection

```powershell
# Get postgres pod name
kubectl get pods -n faculty-management | findstr postgres

# Connect to postgres (replace POD_NAME)
kubectl exec -it POD_NAME -n faculty-management -- psql -U postgres -d faculty_db

# Inside postgres, run:
\dt

# You should see tables: users, faculty

# Exit postgres:
\q
```

---

## PART 8: SCREENSHOTS FOR SUBMISSION

Take these screenshots:

1. **AKS Cluster in Azure Portal**:
   - Go to: https://portal.azure.com
   - Navigate to: Resource Groups → faculty-management-rg → faculty-aks-cluster
   - Screenshot the overview page

2. **All Pods Running**:
   ```powershell
   kubectl get pods -n faculty-management
   ```
   Screenshot showing all pods with "Running" status

3. **All Services**:
   ```powershell
   kubectl get services -n faculty-management
   ```
   Screenshot showing services with EXTERNAL-IP

4. **Application Working**:
   - Screenshot of browser showing your app at http://EXTERNAL_IP
   - Screenshot of login page
   - Screenshot after registering and logging in

5. **Pod Details**:
   ```powershell
   kubectl describe pods -n faculty-management
   ```
   Screenshot showing pod details

6. **Deployment Details**:
   ```powershell
   kubectl get deployments -n faculty-management
   ```
   Screenshot showing all deployments

---

## TROUBLESHOOTING

### Problem: Pods not starting

**Solution**:
```powershell
# Check pod status
kubectl describe pod POD_NAME -n faculty-management

# Check events
kubectl get events -n faculty-management --sort-by='.lastTimestamp'
```

### Problem: Can't pull Docker images

**Solution**: Make sure your Docker Hub images are public:
1. Go to https://hub.docker.com
2. Click on your repository
3. Go to Settings
4. Make sure "Visibility" is set to "Public"

### Problem: External IP stays <pending>

**Solution**: Wait 5 minutes. If still pending:
```powershell
kubectl describe service faculty-frontend -n faculty-management
```
Check for any errors in the events

### Problem: Backend can't connect to database

**Solution**:
```powershell
# Check if postgres is running
kubectl get pods -n faculty-management | findstr postgres

# Check postgres logs
kubectl logs POSTGRES_POD_NAME -n faculty-management
```

---

## CLEANUP (AFTER GRADING)

**⚠️ IMPORTANT**: Do this AFTER you've submitted and been graded!

```powershell
# Delete the entire resource group (this deletes everything)
az group delete --name faculty-management-rg --yes --no-wait
```

This will delete:
- AKS cluster
- All nodes
- All resources
- Everything

**This stops all charges!**

---

## COST INFORMATION

**Estimated Cost**:
- AKS cluster with 2 B2s nodes: ~$60-80/month
- LoadBalancer: ~$20/month
- Storage: ~$5/month

**💡 TIP**: Delete resources immediately after grading to minimize costs!

**Free Tier**: If you have Azure free credits ($200 for 30 days), this is covered!

---

## SUMMARY CHECKLIST

- [ ] Azure CLI installed
- [ ] kubectl installed
- [ ] Docker images pushed to Docker Hub
- [ ] Kubernetes manifests updated with Docker Hub username
- [ ] Azure account logged in
- [ ] Resource group created
- [ ] AKS cluster created
- [ ] kubectl connected to cluster
- [ ] All Kubernetes manifests applied
- [ ] All pods running
- [ ] Services created
- [ ] External IP obtained
- [ ] Application accessible via browser
- [ ] Screenshots taken
- [ ] Ready for submission!

---

## NEED HELP?

If you get stuck:
1. Check the error message carefully
2. Look in the Troubleshooting section
3. Run: `kubectl get events -n faculty-management`
4. Check pod logs: `kubectl logs POD_NAME -n faculty-management`

---

**Good luck! 🚀**
