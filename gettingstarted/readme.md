# Step-by-Step Tutorial: Dockerized Nginx Multi-App Setup

This tutorial walks through building, running, and testing an Nginx-based multi-app setup using Docker and Docker Compose. After each step, you'll build and launch the container(s) to verify progress.

---

## 1. 🔧 Guide: Nginx in Docker

### Step 1.1: Create `Dockerfile`

1. Create a file named `Dockerfile` with the following content:

   ```dockerfile
   FROM nginx:latest
   COPY config/nginx.conf /etc/nginx/nginx.conf
   ```
2. Build the Docker image:

   ```bash
   docker build -t custom-nginx:step1 .
   ```
3. Run the container:

   ```bash
   docker run -d --name nginx-step1 -p 8080:80 custom-nginx:step1
   ```
4. Verify container is running and check logs:

   ```bash
   docker ps
   docker logs nginx-step1
   ```
5. Stop and remove the container:

   ```bash
   docker rm -f nginx-step1
   ```

---

## 2. 🌐 Guide: Docker Networking

### Step 2.1: Create a User-Defined Network

1. Create a network:

   ```bash
   docker network create webnet
   ```
2. Verify the network:

   ```bash
   docker network ls
   ```

### Step 2.2: Attach Container to the Network

1. Run the container on `webnet`:

   ```bash
   docker run -d --name nginx-net -p 8081:80 --network webnet custom-nginx:step1
   ```
2. Verify network attachment:

   ```bash
   docker inspect nginx-net --format='{{json .NetworkSettings.Networks}}'
   ```
3. Cleanup:

   ```bash
   docker rm -f nginx-net
   docker network rm webnet
   ```

---

## 3. 💾 Guide: Docker Storage

### Step 3.1: Project Structure

```
project/
  pages/
    app1/index.html
    app2/index.html
  config/
    nginx.conf
  Dockerfile
```

### Step 3.2: Bind Mount Pages and Config

1. Run container with bind mounts:

   ```bash
   docker run -d --name nginx-storage \
     -p 8082:80 \
     --network bridge \
     -v $(pwd)/pages:/usr/share/nginx/html \
     -v $(pwd)/config/nginx.conf:/etc/nginx/nginx.conf \
     nginx:latest
   ```
2. Test serving a static page:

   ```bash
   curl http://localhost:8082/app1/index.html
   ```
3. Stop and remove:

   ```bash
   docker rm -f nginx-storage
   ```

---

## 4. 🧩 Guide: Multi-Container Linkage with Docker Compose

### Step 4.1: Create `docker-compose.yml`

```yaml
version: '3.8'
services:
  web:
    build: .
    image: custom-nginx:final
    ports:
      - "8080:80"
      - "9090:80"
    volumes:
      - ./pages:/usr/share/nginx/html
      - ./config/nginx.conf:/etc/nginx/nginx.conf
    networks:
      - webnet

networks:
  webnet:
    driver: bridge
```

### Step 4.2: Build & Launch with Compose

1. Build & start services:

   ```bash
   docker-compose up --build -d
   ```
2. Verify containers:

   ```bash
   docker-compose ps
   ```
3. Test endpoints:

   ```bash
   curl http://localhost:8080/app1/index.html
   curl http://localhost:9090/app2/index.html
   ```
4. Tear down:

   ```bash
   docker-compose down
   ```

---

## 5. ✅ Guide: Monitoring & Health Checks

### Step 5.1: Add Healthcheck in Compose

Update `docker-compose.yml` service:

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost/app1/index.html"]
  interval: 30s
  timeout: 10s
  retries: 3
```

### Step 5.2: Verify Health Status

1. Launch services:

   ```bash
   docker-compose up -d
   ```
2. Inspect health:

   ```bash
   docker inspect nginx_docker_step_by_step_web_1 \
     --format='{{json .State.Health}}'
   ```
3. Cleanup:

   ```bash
   docker-compose down
   ```

---

## 6. 🛠 Guide: Diagnostics

### Step 6.1: Shell Access with `docker exec`

```bash
docker-compose up -d

docker exec -it nginx_docker_step_by_step_web_1 bash
```

### Step 6.2: View Logs

```bash
docker-compose logs web
```

### Step 6.3: Resource Usage with `docker stats`

```bash
docker stats
```

### Step 6.4: Individual Container Stats

```bash
docker stats nginx_docker_step_by_step_web_1
```

---

🚀 **All steps now verify that containers launch and serve content before moving on.**
