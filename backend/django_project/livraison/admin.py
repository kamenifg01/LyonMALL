from django.contrib import admin
from .models import Commande, PrestataireDeLivraison, Livraison

@admin.register(Commande)
class CommandeAdmin(admin.ModelAdmin):
    list_display = ('id', 'utilisateur_id', 'date_commande', 'statut', 'total')

@admin.register(PrestataireDeLivraison)
class PrestataireDeLivraisonAdmin(admin.ModelAdmin):
    list_display = ('prestataire_id', 'nom', 'adresse')

@admin.register(Livraison)
class LivraisonAdmin(admin.ModelAdmin):
    list_display = ('id', 'commande_id', 'prestataire_id', 'statut_livraison', 'numero_suivi', 'date_envoi', 'date_livraison')
