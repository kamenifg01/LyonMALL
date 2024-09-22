# Étape 1: Utilise une version plus récente de Node.js (au moins 18.x)
FROM node:18 AS build

# Crée un répertoire de travail
WORKDIR /app

# Copie les fichiers package.json et package-lock.json
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie le reste du code
COPY . .

# Construis l'application Angular pour la production
RUN npm run build --prod

# Étape 2: Servir l'application via NGINX
FROM nginx:alpine
COPY --from=build /app/dist/lyonmall-frontend /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
