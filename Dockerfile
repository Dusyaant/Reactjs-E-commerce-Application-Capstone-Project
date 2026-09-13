# Use the lightweight Nginx image
FROM nginx:alpine

# Remove the default Nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy our project files into the Nginx web directory
COPY . /usr/share/nginx/html/

# Expose port 80 for web traffic
EXPOSE 80

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]