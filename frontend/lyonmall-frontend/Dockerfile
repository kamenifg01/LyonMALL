# Utiliser une image officielle de Node.js
FROM node:14

# Créer un répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers
COPY . .

# Exposer le port sur lequel l'application écoute
EXPOSE 3000

# Définir la commande par défaut pour exécuter l'application
CMD ["npm", "start"]
