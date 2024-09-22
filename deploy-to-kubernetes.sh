#!/bin/bash

# Appliquer les fichiers de déploiement Kubernetes
kubectl apply -f kubernetes/node-deployment.yaml
kubectl apply -f kubernetes/django-deployment.yaml
