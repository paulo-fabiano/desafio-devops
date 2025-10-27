# Build
FROM node:25.0.0-alpine3.22 AS build
WORKDIR /build
ENV NODE_ENV=production
COPY package*.json .
RUN npm install 
COPY . .
# Production
FROM node:25.0.0-alpine3.22
WORKDIR /app
COPY --from=build --chown=node:node /build .
EXPOSE 3000
USER node
CMD [ "npm", "start" ]
