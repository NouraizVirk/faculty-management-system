# Faculty Management System

![CI/CD Pipeline](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Faculty%20Management%20System%20CI/CD%20Pipeline/badge.svg)

A cloud-native Faculty Management System with complete DevOps implementation including containerization, CI/CD, Kubernetes deployment, Ansible automation, and Selenium testing.

## 🚀 Features

- **Authentication System**: Secure login and registration
- **Faculty Management**: Add, view, edit, and delete faculty members
- **Dashboard**: Statistics and recent faculty overview
- **Search & Filter**: Easy faculty lookup
- **Responsive Design**: Works on all devices

## 🏗️ Architecture

- **Frontend**: React.js with React Router
- **Backend**: Node.js with Express
- **Database**: PostgreSQL
- **Containerization**: Docker & Docker Compose
- **CI/CD**: GitHub Actions
- **Orchestration**: Kubernetes (AKS)
- **Configuration Management**: Ansible
- **Testing**: Selenium WebDriver

## 📋 Prerequisites

- Node.js 18+
- Docker & Docker Compose
- PostgreSQL (or use Docker)
- Git

## 🔧 Local Development

### Using Docker Compose (Recommended)

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# Start all services
docker-compose up -d

# Access the application
# Frontend: http://localhost:3000
# Backend: http://localhost:5000
# Database: localhost:5432
```

### Manual Setup

#### Backend
```bash
cd backend
npm install
npm start
```

#### Frontend
```bash
cd frontend
npm install
npm start
```

#### Database
```bash
# Create PostgreSQL database
createdb faculty_db
```

## 🧪 Testing

### Backend Tests
```bash
cd backend
npm test
```

### Frontend Tests
```bash
cd frontend
npm test
```

### Selenium Tests
```bash
cd selenium-tests
python test_faculty_system.py
```

## 🐳 Docker

### Build Images
```bash
docker-compose build
```

### Run Containers
```bash
docker-compose up -d
```

### Stop Containers
```bash
docker-compose down
```

## 🔄 CI/CD Pipeline

The project includes automated CI/CD pipeline using GitHub Actions:

- ✅ Build frontend and backend
- ✅ Run automated tests
- ✅ Build and push Docker images
- ✅ Deploy to Kubernetes (AKS)

**Pipeline triggers on**:
- Push to `main`, `master`, or `develop` branches
- Pull requests to `main` or `master`

See [CI-CD-SETUP.md](CI-CD-SETUP.md) for detailed setup instructions.

## ☸️ Kubernetes Deployment

Deploy to Azure Kubernetes Service:

```bash
# Apply Kubernetes manifests
kubectl apply -f k8s/

# Check deployment status
kubectl get all -n faculty-management
```

## 🔧 Ansible Configuration

Automate server setup and configuration:

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

## 📊 Project Structure

```
.
├── backend/                 # Node.js/Express backend
│   ├── Dockerfile
│   ├── server.js
│   ├── db.js
│   └── tests/
├── frontend/                # React frontend
│   ├── Dockerfile
│   ├── src/
│   │   ├── pages/
│   │   ├── components/
│   │   └── context/
│   └── public/
├── k8s/                     # Kubernetes manifests
├── ansible/                 # Ansible playbooks
├── selenium-tests/          # Selenium test scripts
├── .github/workflows/       # CI/CD pipelines
└── docker-compose.yml       # Docker Compose configuration
```

## 🎯 DevOps Implementation

### Section A: Containerization ✅
- Separate Dockerfiles for frontend, backend, and database
- Docker Compose with networking and volume persistence

### Section B: CI/CD Automation ✅
- GitHub Actions pipeline with build, test, Docker, and deployment stages
- Automated triggers on push and pull requests

### Section C: Kubernetes (AKS) ✅
- Deployment to Azure Kubernetes Service
- Service exposure with LoadBalancer
- ConfigMaps and Secrets management

### Section D: Ansible ✅
- Inventory file for target machines
- Playbooks for software installation and configuration
- Multi-host/role setup

### Section E: Selenium ✅
- Automated UI tests
- Login, form submission, and navigation tests
- Execution reports

## 📸 Screenshots

Screenshots for each section are available in the `screenshots/` directory.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📝 License

This project is created for educational purposes.

## 👥 Authors

- Your Name - DevOps Engineer

## 🙏 Acknowledgments

- University DevOps Course
- Docker Documentation
- Kubernetes Documentation
- GitHub Actions Documentation
