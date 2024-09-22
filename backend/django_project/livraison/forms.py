from django import forms
from .models import Commande, PrestataireDeLivraison, Livraison, Client

class CommandeForm(forms.ModelForm):
    class Meta:
        model = Commande
        fields = ['utilisateur', 'date_commande', 'statut', 'total']

class PrestataireDeLivraisonForm(forms.ModelForm):
    class Meta:
        model = PrestataireDeLivraison
        fields = ['nom', 'adresse']

class LivraisonForm(forms.ModelForm):
    class Meta:
        model = Livraison
        fields = ['id', 'prestataire_id', 'statut_livraison', 'numero_suivi', 'date_envoi', 'date_livraison']

