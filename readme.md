# Dockerized Nginx Multi‑App Repository

This repository contains two main folders:

```
├── gettingstarted
│   └── Step‑by‑step tutorial covering Docker concepts:
│       1. Building an Nginx Docker image
│       2. Docker networking
│       3. Using volumes for storage
│       4. Multi‑container linkage with Docker Compose
│       5. Health checks & monitoring
│       6. Diagnostics (exec, logs, stats)
│
└── task
    └── Hands‑on exercise:
        •  Fix the provided Dockerfile, docker-compose.yml, and nginx.conf
        •  Restore two apps at ports 8080 and 9090
        •  Verify “Hello from App 1!” and “Hello from App 2!”
        •  Submit your corrected files
```

## Folder Details

* **gettingstarted/**

  * A guided tutorial with examples and commands
  * Sample `Dockerfile`, `nginx.conf`, and `docker-compose.yml`
  * Static pages under `pages/app1` and `pages/app2`
  * Instructions to build, run, and verify each step

* **task/**

  * A broken starter project to practice fixes
  * Includes misconfigured `Dockerfile`, `docker-compose.yml`, and `nginx.conf`
  * Two HTML pages under `pages/`
  * Your task: correct configurations, rebuild images, and serve both apps

## Quickstart

1. **Tutorial**: Navigate to `gettingstarted/`, follow each numbered step, and run:

   ```bash
   docker build    # for Dockerfile steps
   docker run      # for individual container tests
   docker network  # for networking tests
   docker-compose up --build  # for multi-container tests
   ```

2. **Exercise**: Switch to `task/`, apply your fixes, then:

   ```bash
   docker-compose up --build -d

   curl http://localhost:8080/app1/index.html  # → "Hello from App 1!"
   curl http://localhost:9090/app2/index.html  # → "Hello from App 2!"
   ```

3. **Submit** your updated files via PR or attach them here.

---

🚀 Happy Dockerizing!
