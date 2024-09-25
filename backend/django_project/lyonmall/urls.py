from django.contrib import admin
from django.urls import path

from .views.projet_views import (
    ajouter_au_panier,
    retirer_du_panier,
    afficher_panier,
    creer_commande,
    suivre_commande,
    liste_commandes,
    annuler_commande,
    create_checkout_session,
    success,
    cancel
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('ajouter_au_panier/<int:produit_id>/', ajouter_au_panier, name='ajouter_au_panier'),
    path('retirer_du_panier/<int:produit_id>/', retirer_du_panier, name='retirer_du_panier'),
    path('afficher_panier/', afficher_panier, name='afficher_panier'),
    path('creer_commande/', creer_commande, name='creer_commande'),
    path('suivre/<int:commande_id>/', suivre_commande, name='suivre_commande'),
    path('annuler/<int:commande_id>/', annuler_commande, name='annuler_commande'),
    path('mes_commandes/', liste_commandes, name='mes_commandes'),
    path('checkout/<int:commande_id>/', create_checkout_session, name='checkout'),
    path('success/', success, name='success'),
    path('cancel/', cancel, name='cancel'),
]
