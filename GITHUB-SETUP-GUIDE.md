# GitHub Setup and Push Guide

## Step 1: Create GitHub Repository

1. **Go to GitHub**: https://github.com
2. **Login** to your account
3. **Click** the "+" icon (top right) → "New repository"
4. **Fill in**:
   - Repository name: `faculty-management-system` (or any name you like)
   - Description: "Faculty Management System with DevOps Implementation"
   - Visibility: **Public** (important for free CI/CD)
   - **DO NOT** check "Initialize with README" (we already have files)
5. **Click** "Create repository"

**Copy the repository URL** (looks like: `https://github.com/YOUR_USERNAME/faculty-management-system.git`)

---

## Step 2: Initialize Git and Push to GitHub

Open PowerShell in your project directory and run these commands:

### Initialize Git Repository
```powershell
git init
```

### Add All Files
```powershell
git add .
```

### Commit Files
```powershell
git commit -m "Initial commit: Faculty Management System with CI/CD, Docker, and Kubernetes"
```

### Set Main Branch
```powershell
git branch -M main
```

### Add Remote Repository
**Replace YOUR_USERNAME and YOUR_REPO with your actual values!**
```powershell
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
```

Example:
```powershell
git remote add origin https://github.com/johnsmith/faculty-management-system.git
```

### Push to GitHub
```powershell
git push -u origin main
```

**You'll be prompted for credentials**:
- Username: Your GitHub username
- Password: Use a **Personal Access Token** (not your password)

---

## Step 3: Create GitHub Personal Access Token (if needed)

If you don't have a token:

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a name: "Faculty Management System"
4. Select scopes:
   - ✅ `repo` (all)
   - ✅ `workflow`
5. Click "Generate token"
6. **COPY THE TOKEN** (you won't see it again!)
7. Use this token as your password when pushing

---

## Step 4: Add GitHub Secrets for CI/CD

1. Go to your repository on GitHub
2. Click "Settings" tab
3. Click "Secrets and variables" → "Actions"
4. Click "New repository secret"

### Add These Secrets:

#### Secret 1: DOCKER_USERNAME
- Name: `DOCKER_USERNAME`
- Value: Your Docker Hub username
- Click "Add secret"

#### Secret 2: DOCKER_PASSWORD
- Name: `DOCKER_PASSWORD`
- Value: Your Docker Hub password or access token
- Click "Add secret"

#### Secret 3: AZURE_CREDENTIALS (Optional - for full pipeline)
- Name: `AZURE_CREDENTIALS`
- Value: Azure service principal JSON (see below)
- Click "Add secret"

#### Secret 4: AZURE_RESOURCE_GROUP (Optional)
- Name: `AZURE_RESOURCE_GROUP`
- Value: `faculty-management-rg`
- Click "Add secret"

#### Secret 5: AZURE_CLUSTER_NAME (Optional)
- Name: `AZURE_CLUSTER_NAME`
- Value: `faculty-aks-cluster`
- Click "Add secret"

---

## Step 5: Get Azure Credentials (Optional - for full pipeline)

If you want the full CI/CD pipeline with AKS deployment:

```powershell
# Login to Azure
az login

# Get your subscription ID
az account show --query id -o tsv

# Create service principal (replace {subscription-id})
az ad sp create-for-rbac --name "faculty-management-sp" --role contributor --scopes /subscriptions/{subscription-id} --sdk-auth
```

**Copy the entire JSON output** and use it as the `AZURE_CREDENTIALS` secret.

---

## Step 6: Verify GitHub Actions

1. Go to your repository on GitHub
2. Click "Actions" tab
3. You should see workflows:
   - "Faculty Management System CI/CD Pipeline"
   - "Simple CI/CD Pipeline (Docker Hub Only)"

**If you added Docker Hub secrets**, the pipeline will run automatically!

---

## Step 7: Trigger the Pipeline

### Option 1: Push a Change
```powershell
# Make a small change
echo "# Faculty Management System" > TEST.md
git add TEST.md
git commit -m "Test CI/CD pipeline"
git push
```

### Option 2: Create a Pull Request
```powershell
# Create a new branch
git checkout -b test-feature
echo "Test" > test.txt
git add test.txt
git commit -m "Test feature"
git push -u origin test-feature
```

Then go to GitHub and create a Pull Request.

---

## Step 8: Monitor Pipeline Execution

1. Go to your repository on GitHub
2. Click "Actions" tab
3. Click on the running workflow
4. Watch the stages execute:
   - ✅ Build Frontend
   - ✅ Build Backend
   - ✅ Test Frontend
   - ✅ Test Backend
   - ✅ Docker Build & Push Frontend
   - ✅ Docker Build & Push Backend
   - ✅ Deploy to AKS (if Azure secrets configured)

---

## Troubleshooting

### Problem: Authentication failed when pushing

**Solution**: Use Personal Access Token instead of password
- Generate token at: https://github.com/settings/tokens
- Use token as password when prompted

### Problem: Pipeline not running

**Solution**: 
- Check if GitHub Secrets are added correctly
- Check if workflow files exist in `.github/workflows/`
- Check "Actions" tab is enabled in repository settings

### Problem: Docker push fails in pipeline

**Solution**:
- Verify `DOCKER_USERNAME` secret is correct
- Verify `DOCKER_PASSWORD` secret is correct
- Make sure Docker Hub repositories exist and are public

### Problem: Can't find workflow files

**Solution**:
```powershell
# Check if workflow files exist
ls .github/workflows/
```

Should show:
- `ci-cd-pipeline.yml`
- `ci-cd-simple.yml`

---

## Quick Commands Summary

```powershell
# Initialize and push
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main

# Future updates
git add .
git commit -m "Your commit message"
git push
```

---

## What Happens After Push?

1. **GitHub Actions triggers** automatically
2. **Pipeline runs**:
   - Builds frontend and backend
   - Runs automated tests
   - Builds Docker images
   - Pushes to Docker Hub
   - Deploys to AKS (if configured)
3. **You can see**:
   - Real-time logs in Actions tab
   - Success/failure status
   - Docker images in Docker Hub
   - Deployed app in AKS

---

## Screenshots for Grading

After pushing, take these screenshots:

1. **GitHub repository** showing all files
2. **GitHub Actions tab** showing workflow runs
3. **Workflow execution** showing all stages
4. **Successful pipeline** with green checkmarks
5. **Docker Hub** showing pushed images
6. **GitHub Secrets** page (blur the values)

---

**Ready to push!** 🚀
