# Set NGINX base image
FROM nginx:latest

# File Author / Maintainer
MAINTAINER myuser "slacksoul@gmail.com"

# Copy HTML files to NGINX directory
COPY html/* /usr/share/nginx/html