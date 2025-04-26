# Step 1: Use an official nginx image as base
FROM nginx:alpine

# Step 2: Remove default nginx html files
RUN rm -rf /usr/share/nginx/html/*

# Step 3: Copy your local project files into nginx directory
COPY . /usr/share/nginx/html

# Step 4: Expose port 80 (for website)
EXPOSE 80

# Step 5: Start nginx
CMD ["nginx", "-g", "daemon off;"]

