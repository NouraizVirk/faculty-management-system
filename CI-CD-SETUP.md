# CI/CD Pipeline Setup Guide

## Overview
This project includes two GitHub Actions workflows:
1. **ci-cd-pipeline.yml** - Full pipeline with AKS deployment
2. **ci-cd-simple.yml** - Simplified pipeline (Docker Hub only)

---

## Prerequisites

### 1. GitHub Repository
- Push this project to a GitHub repository
- Go to repository Settings → Secrets and variables → Actions

### 2. Docker Hub Account
- Create account at https://hub.docker.com
- Create two repositories:
  - `faculty-backend`
  - `faculty-frontend`

### 3. Required GitHub Secrets

Add these secrets in your GitHub repository:

#### For Both Pipelines:
- `DOCKER_USERNAME` - Your Docker Hub username
- `DOCKER_PASSWORD` - Your Docker Hub password or access token

#### For Full Pipeline (with AKS):
- `AZURE_CREDENTIALS` - Azure service principal credentials (JSON format)
- `AZURE_RESOURCE_GROUP` - Azure resource group name
- `AZURE_CLUSTER_NAME` - AKS cluster name

---

## Pipeline Features

### ✅ Task B1: Pipeline Development

#### 1. Build Stage
- **Frontend Build**: Installs dependencies and builds React app
- **Backend Build**: Installs dependencies and prepares Node.js app

#### 2. Automated Tests
- **Frontend Tests**: Runs React test suite
- **Backend Tests**: Runs Mocha test suite
- Tests must pass before proceeding to next stage

#### 3. Docker Image Build and Push
- Builds Docker images for frontend and backend
- Tags images with `latest` and commit SHA
- Pushes to Docker Hub registry
- Uses caching for faster builds

#### 4. Deployment Step
- Deploys to Azure Kubernetes Service (AKS)
- Updates deployments with new image versions
- Waits for rollout completion
- Verifies deployment status

### ✅ Task B2: Trigger Configuration

The pipeline triggers on:
- **Push** to branches: `main`, `master`, `develop`
- **Pull Request** to branches: `main`, `master`

---

## How to Use

### Option 1: Simple Pipeline (Recommended for Testing)

1. **Setup GitHub Secrets**:
   ```
   DOCKER_USERNAME=your_dockerhub_username
   DOCKER_PASSWORD=your_dockerhub_password
   ```

2. **Push to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

3. **Pipeline will automatically**:
   - Build frontend and backend
   - Run automated tests
   - Build Docker images
   - Push images to Docker Hub

4. **View Results**:
   - Go to GitHub → Actions tab
   - See pipeline execution
   - Check Docker Hub for pushed images

### Option 2: Full Pipeline (with AKS Deployment)

1. **Setup Azure AKS** (if not already done)

2. **Create Azure Service Principal**:
   ```bash
   az ad sp create-for-rbac --name "faculty-management-sp" \
     --role contributor \
     --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group} \
     --sdk-auth
   ```

3. **Add all GitHub Secrets** (including Azure credentials)

4. **Push to GitHub** - Full pipeline will run

---

## Pipeline Stages Visualization

```
┌─────────────────────────────────────────────────────────┐
│  TRIGGER: Push/PR to main/master/develop                │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  STAGE 1: BUILD                                          │
│  ├─ Build Frontend (npm ci, npm run build)              │
│  └─ Build Backend (npm ci)                              │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  STAGE 2: AUTOMATED TESTS                                │
│  ├─ Test Frontend (npm test)                            │
│  └─ Test Backend (npm test)                             │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  STAGE 3: DOCKER BUILD & PUSH                            │
│  ├─ Build & Push Frontend Image to Docker Hub           │
│  └─ Build & Push Backend Image to Docker Hub            │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  STAGE 4: DEPLOY TO AKS                                  │
│  ├─ Login to Azure                                       │
│  ├─ Set AKS Context                                      │
│  ├─ Apply Kubernetes Manifests                           │
│  ├─ Update Deployment Images                             │
│  └─ Verify Deployment                                    │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│  ✅ DEPLOYMENT COMPLETE                                  │
└─────────────────────────────────────────────────────────┘
```

---

## Testing the Pipeline

### Test 1: Push to Main Branch
```bash
git add .
git commit -m "Test CI/CD pipeline"
git push origin main
```
**Expected**: Pipeline triggers and runs all stages

### Test 2: Create Pull Request
```bash
git checkout -b feature/test
git add .
git commit -m "Test feature"
git push origin feature/test
```
Then create PR on GitHub
**Expected**: Pipeline runs on PR

### Test 3: Verify Docker Images
```bash
docker pull YOUR_USERNAME/faculty-backend:latest
docker pull YOUR_USERNAME/faculty-frontend:latest
```
**Expected**: Images download successfully

---

## Troubleshooting

### Pipeline Fails at Test Stage
- Check test files exist
- Ensure dependencies are installed
- Review test logs in GitHub Actions

### Docker Push Fails
- Verify Docker Hub credentials
- Check repository names match
- Ensure repositories are public or credentials are correct

### AKS Deployment Fails
- Verify Azure credentials are correct
- Check AKS cluster is running
- Ensure Kubernetes manifests exist in `k8s/` folder
- Verify resource group and cluster names

---

## Screenshots for Submission

Capture these for grading:

1. **GitHub Actions Workflow File** (ci-cd-pipeline.yml)
2. **Pipeline Execution** (GitHub Actions tab showing successful run)
3. **Build Stage Logs** (showing frontend + backend build)
4. **Test Stage Logs** (showing automated tests passing)
5. **Docker Build & Push Logs** (showing images pushed to registry)
6. **Docker Hub** (showing pushed images)
7. **Deployment Logs** (showing AKS deployment)
8. **Pipeline Triggers** (showing it runs on push/PR)

---

## Grading Checklist

### Task B1: Pipeline Development ✅
- [x] Build stage (frontend + backend)
- [x] Automated tests
- [x] Docker image build and push to registry
- [x] Deployment step to Kubernetes

### Task B2: Trigger Configuration ✅
- [x] Pipeline runs on push to main/master/develop
- [x] Pipeline runs on pull request

---

## Next Steps

After CI/CD is working:
1. Proceed to Phase 4: AKS Deployment (if not using full pipeline)
2. Proceed to Phase 5: Ansible Configuration
3. Proceed to Phase 6: Selenium Testing
