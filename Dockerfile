FROM node:alpine3.18
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
EXPOSE 4000
CMD [ "npm", "run", "start" ]

FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]