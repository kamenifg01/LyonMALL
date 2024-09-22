from rest_framework import serializers
from .models import Commande, Client



class ClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ['id', 'nom', 'email', 'mot_de_passe', 'adresse', 'role'] 

class CommandeSerializer(serializers.ModelSerializer):
    client = ClientSerializer(source='utilisateur', read_only=True)
    adresse_livraison = serializers.CharField(source='utilisateur.adresse', read_only=True)

    class Meta:
        model = Commande
        fields = ['id', 'client', 'adresse_livraison', 'date_commande', 'total', 'statut']