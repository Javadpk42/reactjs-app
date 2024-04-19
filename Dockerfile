# FROM node:alpine3.18 as build

# ARG REACT_APP_NODE_ENV
# ARG REACT_APP_SERVER_BASE_URL
# ENV REACT_APP_NODE_ENV=$REACT_APP_NODE_ENV
# ENV REACT_APP_SERVER_BASE_URL=$REACT_APP_SERVER_BASE_URL


# WORKDIR /app
# COPY package.json ./
# RUN npm install
# COPY . .
# EXPOSE 4000
# CMD [ "npm", "run", "start" ]

# FROM nginx:1.23-alpine
# WORKDIR /usr/share/nginx/html
# RUN rm -rf *
# COPY --from=build /app/build .
# EXPOSE 80
# ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

# Stage 1: Build React App
FROM node:alpine3.18 as build

ARG REACT_APP_NODE_ENV
ARG REACT_APP_SERVER_BASE_URL
ENV REACT_APP_NODE_ENV=$REACT_APP_NODE_ENV
ENV REACT_APP_SERVER_BASE_URL=$REACT_APP_SERVER_BASE_URL

WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve React App with NGINX
FROM nginx:1.23-alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



