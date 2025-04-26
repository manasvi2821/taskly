# Taskly 📝

Taskly is a **productivity-focused Task Management Web App** built using **Flutter** for the frontend and **Node.js + Express** for the backend.  
The application is fully **Dockerized** and deployed on **AWS EC2** for cloud hosting.

---

## 🚀 Features

- Add new tasks
- View all tasks
- Mark tasks as completed
- Delete tasks
- Flutter Web frontend
- Node.js backend with Express
- MongoDB database for storage
- Fully Dockerized (frontend + backend)
- Deployed on AWS EC2 instance

---

## 🛠️ Tech Stack

- Frontend: Flutter Web
- Backend: Node.js, Express.js
- Database: MongoDB
- Deployment: Docker, AWS EC2

---

## 📦 Project Structure

taskly/
 ├── taskly-frontend/     # Flutter Web App
 ├── taskly-backend/      # Node.js Backend Server
 ├── README.md

 ---
 ## 🐳 Docker Setup
 Both frontend and backend have separate Dockerfiles.
 - Backend
   cd taskly-backend/
   docker build -t taskly-backend .
   docker run -p 5000:5000 taskly-backend
 - Frontend
   cd taskly-frontend/
   docker build -t taskly-frontend .
   docker run -p 3000:80 taskly-frontend

---
## 🚀 Deployment on AWS EC2
- Docker installed on EC2 instance
- Pulled the images and ran the containers
- Exposed the frontend on port 3000 and backend API on port 5000
