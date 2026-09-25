# End-to-End CI/CD Pipeline & AWS Monitoring for React E-Commerce Application

![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)

**Author:** Dusyaant R  
**Project Type:** DevOps Capstone Project  

---

## 📌 Project Overview
This project implements a fully automated, containerized **Continuous Integration and Continuous Deployment (CI/CD)** pipeline for a React.js E-Commerce web application hosted on **AWS EC2**. 

Using a **Jenkins Multibranch Pipeline** integrated with **GitHub Webhooks**, code commits to the `dev` and `master` branches automatically trigger isolated Docker image builds, push artifacts to **Docker Hub** (Public and Private repositories), and deploy zero-conflicting containers via **Docker Compose** and **Nginx**. Production availability is continuously monitored using an AWS-native observability stack (**Amazon Route 53**, **Amazon CloudWatch**, and **Amazon SNS**).

---

## 🛠️ Technology Stack & Architecture

| Category | Technology / Service | Purpose |
| :--- | :--- | :--- |
| **Frontend Application** | React.js (SPA) | Client-side e-commerce storefront and authentication UI |
| **Web Server** | Nginx (`nginx:alpine`) | Lightweight static asset serving & SPA routing |
| **Containerization** | Docker & Docker Compose | Image packaging, environment isolation, and port binding |
| **Image Registry** | Docker Hub | `dusyaant/dev` (Public) and `dusyaant/prod` (Private) |
| **CI/CD Automation** | Jenkins & GitHub Webhooks | Automated multibranch build, push, and deployment |
| **Cloud Compute** | AWS EC2 (`t3.micro`) | Host infrastructure running Jenkins and Docker Engine |
| **Monitoring & Alerting** | AWS Route 53, CloudWatch, SNS | Endpoint health probing, metric evaluation, and email incident alerts |

---

## 📂 Repository Structure

```text
├── .dockerignore                  # Excludes unnecessary files from Docker build context
├── .gitignore                     # Excludes node_modules, logs, and IDE configs
├── Dockerfile                     # Packages compiled React build into Nginx Alpine container
├── docker-compose.yml             # Defines service, container name, port mapping, and restart policy
├── Jenkinsfile                    # Declarative pipeline for build, Docker Hub push, and deployment
├── build.sh                       # Shell script to build the Docker image
├── deploy.sh                      # Shell script to deploy containers via Docker Compose
├── build/                         # Compiled static production assets (HTML, CSS, JS chunks)
└── screenshot/                    # Categorized verification evidence of pipeline & AWS stack
    ├── Automation Trigger/
    ├── CICD Server & Pipelines/
    ├── Container Registry/
    ├── Health Monitoring & Incident Alerting/
    ├── Infrastructure & Hosting/
    └── Live Application Verification/

```

---

## 🚀 Multi-Branch CI/CD Workflow

The pipeline enforces strict environment separation between development and production branches:

1. **Development (`dev` branch):**
* Pushing code to `dev` fires a GitHub Webhook to Jenkins (`:8080/github-webhook/`).
* Jenkins builds the Docker image and pushes it to the **public** repository: `dusyaant/dev:latest`.
* Docker Compose deploys the container (`devops-webapp-dev`) bound to **Port 80** (`http://54.208.241.183:80`).


2. **Production (`master` branch):**
* Merging or pushing to `master` triggers the production pipeline.
* Jenkins authenticates and pushes the image to the **private** repository: `dusyaant/prod:latest`.
* Docker Compose deploys the production container (`devops-webapp-prod`) bound to **Port 8081** (`http://54.208.241.183:8081`).



---

## 🛡️ Security & Reliability Practices

* **Registry Access Control:** Production images are stored in a private Docker Hub repository (`dusyaant/prod`), while development images remain public (`dusyaant/dev`).
* **Service Port Isolation:** Host ports are isolated across services—Port `80` (Dev App), Port `8081` (Prod App), and Port `8080` (Jenkins Controller).
* **Self-Healing Containers:** Configured `restart: always` in `docker-compose.yml` so containers automatically recover from unexpected process crashes or EC2 reboots.
* **Automated Incident Alerting:** AWS Route 53 probes the application every 30 seconds (with a 3-failure threshold). If `HealthCheckStatus` drops below `1`, CloudWatch triggers an Amazon SNS topic (`App-Health-Alerts`) to dispatch an immediate email alert.

---

## 📸 Project Verification & Evidence

### 1. Infrastructure & Hosting (AWS EC2)

**AWS EC2 `t3.micro` Instance Running (`3/3` Status Checks Passed):**


### 2. Automation Trigger (GitHub Webhooks)

**Active GitHub Webhook Delivering Push Events to Jenkins:**


### 3. CI/CD Server & Multibranch Pipelines (Jenkins)

**Jenkins Main Dashboard:**


**Multibranch Pipeline Overview (`dev` and `master` Passing):**


**Automated Push Trigger on `dev` Branch (Build #14):**


**Production `master` Branch Build Success (Build #22):**


### 4. Container Registry (Docker Hub)

**Updated Public (`dev`) and Private (`prod`) Repositories on Docker Hub:**


### 5. Live Application Verification

**Development Environment Storefront (Port 80):**


**Development Environment Login Route (Port 80):**


**Production Environment Storefront (Port 8081):**


**Production Environment Login Route (Port 8081):**


### 6. Health Monitoring & Incident Alerting (AWS Route 53, CloudWatch & SNS)

**Route 53 Health Check Overview & Status:**


**Route 53 Endpoint Configuration:**


**Route 53 Health Check Metrics (100% Healthy):**


**CloudWatch Alarm Monitoring `HealthCheckStatus` (`OK` State):**


**Confirmed Amazon SNS Topic & Email Subscription (`App-Health-Alerts`):**
