# 🐳 Learning Docker

This repository documents my journey of learning **Docker** - from basic commands to containerizing real applications.

---

## 1. Problem Statement

Developers often face challenges in maintaining consistent environments across machines like version for node, redis, postgres and all. Docker solves this by packaging applications and their dependencies into **containers** ensuring seamless portability and scalability.

---

## 2. Installation of Docker CLI and Desktop

To get started:

- **Download & Install Docker Desktop:**\
  [Docker Desktop Download](https://www.docker.com/products/docker-desktop/)
- **Verify Installation:**
  ```bash
  docker --version
  ```
- Ensure Docker Desktop is running before executing any commands.

---

## 3. Understanding Images vs Containers

| Concept       | Description                                                                                                                                                                       |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Image**     | A lightweight, immutable file that contains everything needed to run an application (code, runtime, libraries). Think of it as a **blueprint** or **template** of an environment. |
| **Container** | A running instance created from that image. It’s like having a **live system** or **desktop** that’s built using the image as its base.                                           |
|               |                                                                                                                                                                                   |

Example:

```bash
docker pull ubuntu # no need as if you do docker run -it ubuntu, it will automatically pull it from hub.docker.com
docker run -it ubuntu
```

---

## 4. Running Ubuntu Image in a Container

Pull and run Ubuntu interactively:

```bash
docker run -it ubuntu bash
```

Inside the container, you can execute Linux commands like `ls`, `pwd`, or install packages using `apt`.

---

## 5. Multiple Containers

You can run multiple containers from the same or different images:

```bash
docker run -d --name container1 ubuntu
docker run -d --name container2 ubuntu
docker ps
```

Each container runs in its isolated environment.

---

## 6. Port Mappings

Used to expose a container’s internal port to the host:

```bash
docker run -d -p 8080:80 nginx # desktop_port:container_port
```

Access your app via `http://localhost:8080`.

---

## 7. Environment Variables

You can pass environment variables to containers:

```bash
docker run -e "APP_ENV=production" ubuntu env
```

Useful for configuring applications dynamically.

---

## 8. Dockerization of Node.js Application

### 8.1 Dockerfile

A `Dockerfile` defines the steps to build your app’s image:

```Dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

Build and run:

```bash
docker build -t my-node-app .
docker run -p 3000:3000 my-node-app
```

### 8.2 Caching Layers

Docker caches intermediate layers during build - changing files lower in the Dockerfile invalidates cache for subsequent steps.\
This helps speed up rebuilds.

### 8.3 Publishing to Docker Hub

Login and push your image:

```bash
docker login
docker tag my-node-app <your-username>/my-node-app:v1
docker push <your-username>/my-node-app:v1
```

---

## 9. Docker Compose

Used for defining and managing multi-container applications.

### 9.1 Services

A sample `docker-compose.yml`:

```yaml
version: "3"
services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
  db:
    image: mongo
    ports:
      - "27017:27017"
```

### 9.2 Port Mapping

The `ports` section maps container ports to host ports (e.g., `3000:3000`).

### 9.3 Environment Variables

Use the `environment` key to define variables:

```yaml
environment:
  - MONGO_URI=mongodb://db:27017/mydb
```

Start all services:

```bash
docker-compose up
```

---

## Conclusion

This repository covers the complete journey from basic Docker commands to running multi-container applications with Docker Compose.\
It serves as a hands-on guide to mastering containerization.

