# Web Service Restore Task

## 🛠️ Task 1: Run & Restore the Web Service

### 🌟 Goal

Restore a broken Docker-based web service so that the following URLs return correct responses:

* `http://<host>:8080/app1/index.html` → **"Hello from App 1!"**
* `http://<host>:9090/app2/index.html` → **"Hello from App 2!"**

---

## 📊 Instructions

### 1.1 Start the Stack

```bash
docker-compose up --build
```

> Builds the Docker images and starts the containers.

---

### 1.2 Stop the Stack

```bash
docker-compose down
```

> Stops and removes containers, networks, and volumes.

---

### 1.3 Observe the Failure

Try accessing the following URLs:

```bash
curl http://localhost:8080/app1/index.html
curl http://localhost:9090/app2/index.html
```

Note the errors, such as:

* Connection refused
* 404 Not Found
* Blank page

---

### 1.4 Identify Misconfigurations

Inspect the provided files and note issues:

* ❌ Dockerfile doesn't copy `nginx.conf` → Nginx uses default config.
* ❌ `docker-compose.yml` missing port mappings for 8080 and 9090.
* ❌ `./pages` not mounted into container at `/usr/share/nginx/html`.
* ❌ `nginx.conf` lacks routes for `/app1` and `/app2`.

---

### 1.5 Fix the Dockerfile

Ensure custom `nginx.conf` is copied into the image:

```Dockerfile
COPY config/nginx.conf /etc/nginx/nginx.conf
```

---

### 1.6 Fix docker-compose.yml

```yaml
services:
  web:
    build: .
    image: custom-nginx
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
    driver: overlay
```

---

### 1.7 Fix nginx.conf

```nginx
events {}

http {
    server {
        listen 80;

        location /app1/ {
            alias /usr/share/nginx/html/app1/;
            index index.html;
        }

        location /app2/ {
            alias /usr/share/nginx/html/app2/;
            index index.html;
        }
    }
}
```

---

### 1.8 Redeploy and Verify

```bash
docker-compose down
docker-compose up --build
```

Verify output:

```bash
curl http://localhost:8080/app1/index.html  # Should return "Hello from App 1!"
curl http://localhost:9090/app2/index.html  # Should return "Hello from App 2!"
```

---

🚀 **Done!** Your services should now be running correctly.
