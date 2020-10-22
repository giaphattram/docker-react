FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# When Dockerfile runs into a FROM, it knows to start kinda a new phase/stage
FROM nginx
# Expose port 80, i.e. the container will listen to port 80
EXPOSE 80
# Copy the folder /app/build from the phase/stage above (from = 0) 
# to a folder in nginx container. Which folder? 
# From https://hub.docker.com/_/nginx, for the purpose of hosting some simple static content,
# the folder is /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html
# The default command of nginx base image is to start nginx server, 
# so we don't need to overwrite default command here