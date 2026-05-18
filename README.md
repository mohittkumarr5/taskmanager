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
