FROM node:latest as build-stage

# Create app directory
WORKDIR /app

# Copy the current directory to the container's app directory
COPY . .

# Install dependencies
RUN npm install

# Build the application
RUN npm run build --prod

# Use the official NGINX image as a parent image
FROM nginx:latest

# Install vim
RUN apt-get update && apt-get install -y vim

# Copy the build output to the default NGINX directory
COPY --from=build-stage /app/dist/angular-i18n-demo/ /usr/share/nginx/html

EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
