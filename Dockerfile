# Step 1: Build the app in image 'builder'
FROM node:12.8-alpine AS builder

WORKDIR /usr/src/app
COPY . .
RUN yarn && yarn build

# Step 2: Use build output from 'builder'
FROM nginx:stable-alpine
LABEL version="1.0"

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
COPY --from=builder /usr/src/app/dist/my-angular-app/ .
