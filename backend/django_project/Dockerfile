# Utilise une image officielle de Python
FROM python:3.9

# Crée un répertoire de travail dans le conteneur
WORKDIR /app

# Installe les dépendances Python depuis requirements.txt
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copie tout le code du projet dans le répertoire de travail
COPY . .

# Expose le port sur lequel l'application Django écoute (par défaut 8000)
EXPOSE 8000

# Commande pour démarrer l'application Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
