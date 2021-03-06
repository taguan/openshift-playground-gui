# Credits from https://dev.to/avatsaev/create-efficient-angular-docker-images-with-multi-stage-builds-1f3n

### STAGE 1: Build ###

# We label our stage as ‘builder’
FROM node:10-alpine as builder

COPY package.json package-lock.json ./

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build

RUN npm ci && mkdir /ng-app && mv ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder

RUN npm run ng build -- --prod --output-path=dist --showCircularDependencies=false


### STAGE 2: Setup ###

FROM nginx:1.14.1-alpine

EXPOSE 8081

ENV REST_SERVER_URL 'http://localhost:8080'

RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
RUN sed -i.bak 's#/var/run/nginx.pid#/tmp/nginx.pid#' /etc/nginx/nginx.conf

RUN chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /tmp

## Copy our default nginx config
COPY nginx/default.conf /etc/nginx/conf.d/

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /ng-app/dist /usr/share/nginx/html
COPY docker-startup.sh /docker-startup.sh

RUN chown -R nginx:nginx /usr/share/nginx/html
RUN chown nginx:nginx /docker-startup.sh

USER nginx:nginx

RUN chmod +x /docker-startup.sh

ENTRYPOINT ["/docker-startup.sh"]
