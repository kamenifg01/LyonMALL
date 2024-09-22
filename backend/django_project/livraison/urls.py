from django.urls import path
from . import views

urlpatterns = [
    path('commandes/', views.commande_list, name='commande_list'),
    path('clients/', views.client_list, name='client_list'),
    path('prestataires/', views.prestataire_list, name='prestataire_list'),
    path('livraison/<int:id>/', views.livraison_detail, name='livraison_detail'),

    path('creer_livraison/<int:commande_id>/', views.creer_livraison_api, name='creer_livraison_api'),

]
