# Use the official Nginx image as the base image
FROM nginx:latest

# Remove the default Nginx website files
RUN rm -rf /usr/share/nginx/html/*

# Copy all project files into the Nginx web directory
COPY . /usr/share/nginx/html/

# Expose port 80 inside the container
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
