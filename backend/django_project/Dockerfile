# Utilise une image officielle de Python 3.10
FROM python:3.10

# Crée un répertoire de travail dans le conteneur
WORKDIR /app

# Installe les dépendances Python depuis requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Installer Locust pour les tests de charge
RUN pip install locust

# Copie tout le code du projet dans le répertoire de travail
COPY . .

# Expose le port sur lequel l'application Django écoute (par défaut 8000)
EXPOSE 8000

# Expose le port pour Locust (par défaut 8089)
EXPOSE 8089

# Commande pour démarrer l'application Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
