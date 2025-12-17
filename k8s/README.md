# Kubernetes Manifests for Faculty Management System

## 📁 Files Overview

| File | Purpose | Type |
|------|---------|------|
| `namespace.yaml` | Creates isolated namespace | Namespace |
| `postgres-secret.yaml` | Database credentials | Secret |
| `postgres-pvc.yaml` | Persistent storage (5Gi) | PersistentVolumeClaim |
| `postgres-deployment.yaml` | PostgreSQL database | Deployment |
| `postgres-service.yaml` | Database service | Service (ClusterIP) |
| `backend-configmap.yaml` | Backend configuration | ConfigMap |
| `backend-deployment.yaml` | Backend API (2 replicas) | Deployment |
| `backend-service.yaml` | Backend service | Service (ClusterIP) |
| `frontend-deployment.yaml` | Frontend UI (2 replicas) | Deployment |
| `frontend-service.yaml` | Frontend service + Public IP | Service (LoadBalancer) |

---

## 🚀 Deployment Order

**IMPORTANT**: Deploy in this exact order!

```bash
# 1. Namespace
kubectl apply -f namespace.yaml

# 2. Database Layer
kubectl apply -f postgres-secret.yaml
kubectl apply -f postgres-pvc.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml

# 3. Backend Layer
kubectl apply -f backend-configmap.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml

# 4. Frontend Layer
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
```

---

## 🔧 Before Deployment

### Update Docker Hub Username

**Edit these files**:

1. **`frontend-deployment.yaml`** (line ~20):
   ```yaml
   image: YOUR_DOCKERHUB_USERNAME/faculty-frontend:latest
   ```
   Change to:
   ```yaml
   image: johnsmith/faculty-frontend:latest  # Use your username
   ```

2. **`backend-deployment.yaml`** (line ~20):
   ```yaml
   image: YOUR_DOCKERHUB_USERNAME/faculty-backend:latest
   ```
   Change to:
   ```yaml
   image: johnsmith/faculty-backend:latest  # Use your username
   ```

---

## 📊 Architecture

```
Internet
   ↓
LoadBalancer (Public IP)
   ↓
Frontend Service (Port 80)
   ↓
Frontend Pods (2 replicas)
   ↓
Backend Service (Port 5000)
   ↓
Backend Pods (2 replicas)
   ↓
PostgreSQL Service (Port 5432)
   ↓
PostgreSQL Pod (1 replica)
   ↓
Persistent Volume (5Gi)
```

---

## 🔍 Verification

### Check All Resources
```bash
kubectl get all -n faculty-management
```

### Check Pods
```bash
kubectl get pods -n faculty-management
```
**Expected**: 5 pods (2 frontend, 2 backend, 1 postgres) - all Running

### Check Services
```bash
kubectl get services -n faculty-management
```
**Expected**: 3 services with frontend showing EXTERNAL-IP

### Get Public URL
```bash
kubectl get service faculty-frontend -n faculty-management
```
**Copy the EXTERNAL-IP and access**: http://EXTERNAL_IP

---

## 🛠️ Troubleshooting

### Pods not starting?
```bash
kubectl describe pod POD_NAME -n faculty-management
kubectl logs POD_NAME -n faculty-management
```

### Can't pull images?
- Make sure images are pushed to Docker Hub
- Make sure images are public
- Check image names in deployment files

### External IP pending?
- Wait 2-3 minutes
- Check: `kubectl describe service faculty-frontend -n faculty-management`

---

## 🗑️ Cleanup

### Delete all resources
```bash
kubectl delete namespace faculty-management
```

### Or delete individually
```bash
kubectl delete -f frontend-service.yaml
kubectl delete -f frontend-deployment.yaml
kubectl delete -f backend-service.yaml
kubectl delete -f backend-deployment.yaml
kubectl delete -f backend-configmap.yaml
kubectl delete -f postgres-service.yaml
kubectl delete -f postgres-deployment.yaml
kubectl delete -f postgres-pvc.yaml
kubectl delete -f postgres-secret.yaml
kubectl delete -f namespace.yaml
```

---

## 📝 Resource Specifications

### Frontend
- **Replicas**: 2
- **Image**: YOUR_USERNAME/faculty-frontend:latest
- **Port**: 3000
- **Service**: LoadBalancer (Port 80)
- **Resources**: 256Mi-512Mi RAM, 250m-500m CPU

### Backend
- **Replicas**: 2
- **Image**: YOUR_USERNAME/faculty-backend:latest
- **Port**: 5000
- **Service**: ClusterIP
- **Resources**: 256Mi-512Mi RAM, 250m-500m CPU

### Database
- **Replicas**: 1
- **Image**: postgres:15-alpine
- **Port**: 5432
- **Service**: ClusterIP
- **Storage**: 5Gi Persistent Volume
- **Resources**: 256Mi-512Mi RAM, 250m-500m CPU

---

## 🔐 Security

- Database credentials stored in Secret
- Non-sensitive config in ConfigMap
- Network isolation via namespace
- Services use ClusterIP (internal) except frontend

---

## 📈 Monitoring

All deployments include:
- **Liveness Probes**: Detect dead containers
- **Readiness Probes**: Detect not-ready containers
- **Resource Limits**: Prevent resource exhaustion

---

## 🎯 For Grading

**Show these commands**:
```bash
# 1. All pods running
kubectl get pods -n faculty-management

# 2. All services
kubectl get services -n faculty-management

# 3. All deployments
kubectl get deployments -n faculty-management

# 4. Everything
kubectl get all -n faculty-management
```

**Access application**: http://EXTERNAL_IP

---

**Need help?** See `AKS-DEPLOYMENT-GUIDE.md` in the root directory.
