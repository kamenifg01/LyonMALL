Étape 1: Créer un fichier de workflow
Naviguer dans ton dépôt GitHub :

Accède au dépôt où tu souhaites configurer CI/CD.
Créer un répertoire pour les workflows :

Crée un répertoire .github/workflows à la racine de ton projet.
Créer un fichier de workflow :

Dans .github/workflows, crée un fichier nommé ci-cd.yml.

Étape 2: Configurer le workflow

Étape 3: Configurer les secrets
Configurer les secrets Kubernetes :
Accède à "Settings" > "Secrets and variables" > "Actions" dans ton dépôt GitHub.
Ajoute un secret nommé KUBECONFIG contenant la configuration de ton cluster Kubernetes.
Étape 4: Test et Exécution
Tester le workflow : Fais un commit dans la branche configurée (par exemple, main) et vérifie que GitHub Actions déclenche correctement le workflow et effectue les étapes définies.