# Set NGINX base image
FROM nginx:latest

# File Author / Maintainer
MAINTAINER myuser "slacksoul@gmail.com"

# Set an health check
HEALTHCHECK --interval=5m --timeout=5s \
    CMD curl -f http://127.0.0.1:80 || exit 1

# Port to expose
EXPOSE 80

# Copy HTML files to NGINX directory
COPY html/* /usr/share/nginx/html