#!/bin/bash

# Construire l'image Docker pour Node.js
cd frontend/node-app
docker build -t node-app:latest .

# Construire l'image Docker pour Django
cd ../../backend/django-app
docker build -t django-app:latest .
