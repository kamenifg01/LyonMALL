from django.shortcuts import render, get_object_or_404,  redirect
from .models import Commande, PrestataireDeLivraison, Livraison, Client
from .serializers import CommandeSerializer, ClientSerializer
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from rest_framework import generics
from .forms import CommandeForm
from django.http import JsonResponse
from django.utils import timezone
import random
import string

class CommandeListCreate(generics.ListCreateAPIView):
    queryset = Commande.objects.all()
    serializer_class = CommandeSerializer

class ClientListCreate(generics.ListCreateAPIView):
    queryset = Client.objects.all()
    serializer_class = ClientSerializer

def commande_list(request):
    commandes = Commande.objects.all()
    return render(request, 'livraison/commande_list.html', {'commandes': commandes})

def client_list(request):
    clients = Client.objects.all()
    return render(request, 'livraison/client_list.html', {'clients': clients})


def prestataire_list(request):
    prestataires = PrestataireDeLivraison.objects.all()
    return render(request, 'livraison/prestataire_list.html', {'prestataires': prestataires})

def livraison_detail(request, id):
    # Essayez de récupérer la livraison
    livraison = Livraison.objects.filter(id=id).first()

    if livraison:
        # Si la livraison existe, afficher ses détails
        context = {'livraison': livraison}
    else:
        # Si la livraison n'existe pas, récupérer la commande correspondante
        commande = Commande.objects.filter(id=id).first()
        context = {'commande': commande}

    return render(request, 'livraison/livraison_detail.html', context)

# Fonction pour générer un numéro de suivi unique
def generate_tracking_number():
    letters_and_digits = string.ascii_uppercase + string.digits
    return 'NUM' + ''.join(random.choices(letters_and_digits, k=8))  # Par exemple : NUMA1B2C3D4

# Détails de la livraison (aucun changement nécessaire ici)
def details_livraison(request, livraison_id):
    livraison = get_object_or_404(Livraison, id=livraison_id)
    statut_class = {
        'Livrée': 'status-delivered',
        'En attente': 'status-pending',
        'Annulée': 'status-canceled',
    }.get(livraison.statut_livraison, '')

    return render(request, 'details_livraison.html', {
        'livraison': livraison,
        'statut_class': statut_class,
    })


@csrf_exempt
def creer_livraison_api(request, commande_id):
    print("Début du traitement")
    if request.method == 'POST':
        try:
            # Récupérer la commande
            commande = Commande.objects.get(id=commande_id)
            print("Commande trouvée:", commande_id)

            # Simulation d'un prestataire par défaut pour le développement
            # Utilisation d'un prestataire existant ou création d'un nouveau prestataire temporaire
            prestataire = PrestataireDeLivraison.objects.first()
            if not prestataire:
                prestataire = PrestataireDeLivraison.objects.create(
                    nom="Prestataire Temporaire",
                    adresse="Adresse Temporaire"
                )
            print("Prestataire sélectionné:", prestataire.nom)

            # Créer la livraison
            livraison = Livraison.objects.create(
                commande_id=commande,
                prestataire_id=prestataire,
                statut_livraison='En attente',
                numero_suivi=generate_tracking_number(),
                date_envoi=timezone.now(),
            )
            print("Livraison créée avec succès")

            # Répondre avec un message de succès
            return JsonResponse({'message': 'Livraison créée avec succès', 'livraison_id': livraison.id}, status=201)

        except Commande.DoesNotExist:
            print("Erreur : Commande introuvable")
            return JsonResponse({'error': 'Commande introuvable'}, status=404)
        except Exception as e:
            print("Erreur inattendue:", e)
            return JsonResponse({'error': 'Erreur interne du serveur'}, status=500)
    return JsonResponse({'error': 'Méthode non autorisée'}, status=405)