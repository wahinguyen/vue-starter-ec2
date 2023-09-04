FROM node:lts-alpine as build
WORKDIR /src
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM steebchen/nginx-spa:stable as production
COPY --from=build /src/dist /app
EXPOSE 80
CMD ["nginx"]