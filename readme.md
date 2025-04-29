Task 1: Run & Restore the Web Service
Goal: Starting from the provided (broken) files, get both

“Hello from App 1!” at http://<host>:8080/app1/index.html

“Hello from App 2!” at http://<host>:9090/app2/index.html

1.1 Start the stack

docker-compose up --build
1.2 Stop the stack

docker-compose down
(These commands build your images, launch the containers, and tear everything down.)

1.3 Observe the failure
In your browser or via curl, hit:

http://<host>:8080/app1/index.html
http://<host>:9090/app2/index.html
Note what goes wrong (e.g. connection refused, 404, blank page).

1.4 Identify all mis-configurations
List every issue in the provided Dockerfile, docker-compose.yml, and nginx.conf that prevents the two pages from serving.

e.g. “Dockerfile never copies custom nginx.conf → Nginx falls back to default config”

1.5 Fix the Dockerfile
Ensure your custom config/nginx.conf is actually baked into the image at /etc/nginx/nginx.conf.

1.6 Fix the Compose file
Update docker-compose.yml so that:

Host ports 8080 → container 80 and 9090 → container 80 are mapped

The local ./pages folder is bind-mounted at /usr/share/nginx/html

Service web attaches to overlay network webnet

1.7 Fix the Nginx config
Edit nginx.conf so that:

Nginx listens on both 80 and 9090

/app1/ serves from /usr/share/nginx/html/app1

/app2/ serves from /usr/share/nginx/html/app2

1.8 Redeploy & verify

docker-compose down
docker-compose up --build
Then confirm:

curl http://<host>:8080/app1/index.html   # “Hello from App 1!”
curl http://<host>:9090/app2/index.html   # “Hello from App 2!”