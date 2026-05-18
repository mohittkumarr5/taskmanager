# DevOps Lab — Task Manager App

A full-stack Task Manager with Node.js backend and HTML/nginx frontend,
containerized with Docker, automated with Jenkins CI/CD.

---

## Project Structure

```
devops-lab/
├── backend/
│   ├── server.js        ← Express REST API
│   ├── package.json
│   └── Dockerfile       ← node:18-alpine, port 5000
├── frontend/
│   ├── index.html       ← Vanilla JS UI
│   └── Dockerfile       ← nginx:alpine, port 80
├── docker-compose.yml   ← Orchestrates both services
├── Jenkinsfile          ← CI/CD pipeline
└── .gitignore
```

---

## ▶ Step-by-Step Lab Commands

### 1. Git Setup
```bash
git init
git add .
git commit -m "Initial commit: Task Manager app"

# If pushing to GitHub/GitLab:
git remote add origin <your-repo-url>
git push -u origin main
```

### 2. Run Backend Locally (without Docker)
```bash
cd backend
npm install
node server.js
# → Running at http://localhost:5000
```

### 3. Test API with curl
```bash
# Get all tasks
curl http://localhost:5000/api/tasks

# Create a task
curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"My new task"}'

# Toggle done (replace 1 with task id)
curl -X PUT http://localhost:5000/api/tasks/1

# Delete a task
curl -X DELETE http://localhost:5000/api/tasks/1

# Health check
curl http://localhost:5000/health
```

### 4. Docker — Build & Run Individually
```bash
# Backend
docker build -t taskmanager-backend ./backend
docker run -d -p 5000:5000 --name backend taskmanager-backend

# Frontend
docker build -t taskmanager-frontend ./frontend
docker run -d -p 3000:80 --name frontend taskmanager-frontend
```

### 5. Docker Compose — Run Everything
```bash
# Start
docker-compose up -d

# View running containers
docker ps

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

### 6. Jenkins Pipeline Setup
1. Open Jenkins → New Item → Pipeline
2. Set "Pipeline script from SCM" → Git → paste repo URL
3. Branch: `main`, Script Path: `Jenkinsfile`
4. Save → Build Now
5. Watch stages: Clone → Install → Build → Deploy → Health Check

### 7. Access the App
- Frontend UI: http://localhost:3000
- Backend API: http://localhost:5000/api/tasks

---

## API Reference

| Method | Endpoint          | Description        |
|--------|-------------------|--------------------|
| GET    | /api/tasks        | Get all tasks      |
| POST   | /api/tasks        | Create a task      |
| PUT    | /api/tasks/:id    | Toggle done/undone |
| DELETE | /api/tasks/:id    | Delete a task      |
| GET    | /health           | Health check       |

---

## Azure Viva Quick Points
- **Azure Container Registry (ACR)**: Push Docker images here
- **Azure App Service**: Deploy containers from ACR
- **Azure DevOps Pipelines**: Alternative to Jenkins
- **Resource Group**: Logical container for all Azure resources
- **az login** → az acr build → az webapp create

---

## Docker Viva Quick Points
- `Dockerfile` — recipe to build an image
- `docker build` — creates image from Dockerfile
- `docker run` — starts a container from image
- `docker ps` — list running containers
- `docker-compose up` — starts multi-container app
- Multi-stage build used in backend (builder → production)
- Volumes, Networks, Bridge driver

## Git & Jenkins Viva Quick Points
- `git init / add / commit / push` — basic workflow
- Branching: `git checkout -b feature/name`
- Jenkins Pipeline stages: Clone → Build → Test → Deploy
- `Jenkinsfile` lives in root of repo (Pipeline as Code)
- `checkout scm` pulls code from configured repo
