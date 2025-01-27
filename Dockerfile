FROM node:18-alpine AS build 

WORKDIR /app/build 

COPY . .

RUN ls ./src/Layouts/Authenticated


RUN npm install


RUN npm run build

FROM nginx:alpine

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/build/dist /usr/share/nginx/html

EXPOSE 80/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]