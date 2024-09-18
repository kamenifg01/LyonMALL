# Étape 1: Construire l'application Angular
FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Étape 2: Servir l'application via NGINX
FROM nginx:alpine
COPY --from=build /app/dist/your-angular-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
