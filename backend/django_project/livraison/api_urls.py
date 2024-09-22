from django.urls import path
from .views import CommandeListCreate, ClientListCreate

urlpatterns = [
    path('commandes/', CommandeListCreate.as_view(), name='commande-list-create'),
    path('clients/', ClientListCreate.as_view(), name='client-list-create'),

]
