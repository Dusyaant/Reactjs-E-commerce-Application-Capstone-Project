# 🛒 DevOps Capstone Project: Reactjs E-commerce CI/CD Pipeline

![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)

An end-to-end DevOps pipeline automating the build, containerization, and deployment of a ReactJS e-commerce web application ("Trendify") using Docker and Jenkins.

## 📋 Project Overview

This repository contains the source code, Docker configuration, and Jenkins pipeline required to build and deploy the React e-commerce application. The primary goal of this capstone is to demonstrate a fully automated Continuous Integration and Continuous Deployment (CI/CD) pipeline, from source commit to a running containerized application.

### 🛠️ Tech Stack & Tools

* **Frontend:** React.js
* **Containerization:** Docker, Docker Hub (`dusyaant/dev`)
* **Container Orchestration:** Docker Compose
* **CI/CD Automation:** Jenkins (Declarative Pipeline via `Jenkinsfile`)
* **Version Control:** Git, GitHub

---

## 🏗️ Architecture & CI/CD Pipeline Explanation

The deployment process is fully automated via Jenkins. The pipeline executes the following stages:

1. **Source Control:** Developer pushes code changes to the `dev` branch on GitHub.
2. **Build:** Jenkins triggers `build.sh`, which installs dependencies and builds the production React bundle.
3. **Dockerize:** Jenkins builds a Docker image from the `Dockerfile`, packaging the production build to be served by the container.
4. **Push:** Jenkins pushes the new image (`dusyaant/dev:latest`) to Docker Hub.
5. **Deploy:** Jenkins triggers `deploy.sh`, which pulls the latest image and rolls out the container via `docker-compose.yml`.
6. **Expose:** The container (`devops-webapp-dev`) is exposed on port `80`, routing external HTTP traffic to the application.

> [Add any specific trigger detail here — e.g. GitHub webhook vs. manual build — if your Jenkins job is configured with one.]

---

## ⚙️ Setup & Deployment Instructions

### 1. Local Development

```bash
git clone https://github.com/Dusyaant/Reactjs-E-commerce-Application-Capstone-Project.git
cd Reactjs-E-commerce-Application-Capstone-Project
npm install
npm start
```

### 2. Build & Containerize

```bash
# Build the production bundle
./build.sh

# Build the Docker image
docker build -t dusyaant/dev:latest .
```

### 3. Deploy with Docker Compose

```bash
docker-compose up -d
```

The application will be available at `http://localhost`.

### 4. Jenkins Configuration

* Installed Jenkins on [EC2 / local host — fill in your actual setup].
* Installed required plugins: Docker Pipeline, Git.
* Added global credentials for Docker Hub (`dusyaant`).
* Created a Pipeline project pointing at this repository's `Jenkinsfile`.

---

## 📸 Project Evidence & Screenshots

All visual proof of the working pipeline and application can be found in the `/screenshot` directory of this repository.

* `[screenshot-1].png` – App running locally in Docker.
* `[screenshot-2].png` – Docker Hub repository updated with latest image.
* `[screenshot-3].png` – Jenkins pipeline dashboard showing successful build/deploy.
* `[screenshot-4].png` – Live application view.

> Rename these to match the actual files in your `/screenshot` folder.

---

## 🧹 Cleanup

To tear down the running deployment:

```bash
docker-compose down
```

---

**Author:** Dusyaant R.
