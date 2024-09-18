1-Lien pour installer prometheus:
https://github.com/prometheus/prometheus/releases/download/v2.53.2/prometheus-2.53.2.windows-amd64.zip

2- unzip le dans monitoring\prometheus

3- Ouvre prometheus.yml et mets s'y ce que j'ai mis dans prometheus_.yml

4- Pour lancer:
   - dans le cmd fais: "cd C:\chemin d'acces\monitoring\prometheus"
   - "prometheus.exe --config.file=prometheus.yml"

5- Vérifie que Prometheus fonctionne :

Ouvre un navigateur web et va à l’adresse http://localhost:9090. Tu devrais voir l’interface web de Prometheus.