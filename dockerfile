FROM nginx:alpine

# TESTING TO REMOVE
# COPY config/nginx.conf /etc/nginx/nginx.conf

# Copy the page content
COPY pages /usr/share/nginx/html
