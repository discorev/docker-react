# Builder stage to get node dependancies and run the build
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# production image phase taking the output of the build process
# the default CMD of nginx starts nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# NOTE: this does not bind this port, but simply lets other users
#       know that it is available
EXPOSE 80
