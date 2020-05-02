# as keyword is the tag to name this step
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Docker knows that a new FROM statement means wait for the previous block to finish.
FROM nginx

# Nginx expects static files to be in the nginx/html folder.
COPY --from=builder /app/build /usr/share/nginx/html

