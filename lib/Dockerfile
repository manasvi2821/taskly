# Use the nginx image
FROM nginx:alpine

# Remove default nginx web page
RUN rm -rf /usr/share/nginx/html/*

# Copy your Flutter web build output to nginx html folder
COPY build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
