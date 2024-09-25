import logging
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from functools import wraps
from django.conf import settings
from ..models.models_commande import Panier, Produits, Commandes, CommandeProduits, ArticlePanier, Paiements
import stripe
from django.views.decorators.csrf import csrf_exempt

logger = logging.getLogger(__name__)

# Constantes pour les messages d'erreur
PANIER_VIDE_ERROR = "Votre panier est vide"

def get_user_cart(user):
    """Fonction utilitaire pour récupérer ou créer le panier de l'utilisateur"""
    return Panier.objects.get_or_create(utilisateur=user)[0]

def check_empty_cart(view_func):
    """
    Décorateur pour vérifier si le panier est vide.
    Renvoie un message d'erreur si le panier est vide.
    """
    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        panier = get_user_cart(request.user)
        if not panier.articles.exists():
            return JsonResponse({'error': PANIER_VIDE_ERROR}, status=400)
        return view_func(request, *args, **kwargs)
    return wrapper
@csrf_exempt
@login_required
def ajouter_au_panier(request, produit_id):
    """Ajoute un produit au panier de l'utilisateur"""
    produit = get_object_or_404(Produits, id=produit_id)
    panier = get_user_cart(request.user)

    article_panier, created = ArticlePanier.objects.get_or_create(panier=panier, produit=produit)
    if not created:
        article_panier.quantite += 1
        article_panier.save()

    return JsonResponse({"message": "Produit ajouté au panier", "quantite": article_panier.quantite})
@csrf_exempt
@login_required
def retirer_du_panier(request, produit_id):
    """Retire un produit du panier de l'utilisateur"""
    panier = get_user_cart(request.user)
    produit = get_object_or_404(Produits, id=produit_id)
    ArticlePanier.objects.filter(panier=panier, produit=produit).delete()

    return JsonResponse({"message": "Produit retiré du panier"})

@login_required
@csrf_exempt
@check_empty_cart
def afficher_panier(request):
    """Affiche le contenu du panier de l'utilisateur"""
    panier = get_user_cart(request.user)
    articles = [
        {
            "produit_id": item.produit.id,
            "nom": item.produit.nom,
            "quantite": item.quantite,
            "prix": item.produit.prix,
            "prix_total": item.calculer_total(),
        }
        for item in panier.articles.all()
    ]
    return JsonResponse({"articles": articles, "prix_total": panier.calculer_total()})

@login_required
@csrf_exempt
@check_empty_cart
def creer_commande(request):
    """Crée une commande à partir du panier de l'utilisateur"""
    panier = get_user_cart(request.user)

    if request.method == 'POST':
        try:
            commande = Commandes.objects.create(utilisateur=request.user)

            for item in panier.articles.all():
                CommandeProduits.objects.create(
                    commande=commande, 
                    produit=item.produit, 
                    quantite=item.quantite
                )

            commande.recalculer_total()
            panier.articles.all().delete()  # Vider le panier
            return JsonResponse({'message': 'Commande créée', 'commande_id': commande.id})
        except Exception as e:
            return JsonResponse({'error': f'Erreur lors de la création de commande: {str(e)}'}, status=400)

    return JsonResponse({'error': 'Méthode non autorisée'}, status=405)

@login_required
@csrf_exempt
def suivre_commande(request, commande_id):
    """Permet à l'utilisateur de suivre une commande spécifique"""
    commande = get_object_or_404(Commandes, pk=commande_id, utilisateur=request.user)
    produits = CommandeProduits.objects.filter(commande=commande).select_related('produit')
    
    produits_detail = [{
        'produit_id': item.produit.id,
        'nom': item.produit.nom,
        'quantite': item.quantite,
        'prix': item.produit.prix
    } for item in produits]

    return JsonResponse({'commande': commande.id, 'produits': produits_detail})

@login_required
@csrf_exempt
def liste_commandes(request):
    """Affiche la liste des commandes de l'utilisateur"""
    commandes = Commandes.objects.filter(utilisateur=request.user)
    return JsonResponse({'commandes': list(commandes.values())})

@login_required
@csrf_exempt
def annuler_commande(request, commande_id):
    """Permet à l'utilisateur d'annuler une commande en attente"""
    commande = get_object_or_404(Commandes, pk=commande_id, utilisateur=request.user)
    if commande.statut == 'pending':
        commande.statut = 'cancelled'
        commande.save()
    return JsonResponse({'message': 'Commande annulée'})

@login_required
@csrf_exempt
def create_checkout_session(request, commande_id):
    """Crée une session de paiement Stripe pour une commande"""
    commande = get_object_or_404(Commandes, id=commande_id, utilisateur=request.user)
    
    try:
        session_paiement = stripe.checkout.Session.create(
            payment_method_types=['card'],
            line_items=[{
                'price_data': {
                    'currency': 'eur',
                    'product_data': {'name': f'Commande {commande.id}'},
                    'unit_amount': int(commande.total * 100),
                },
                'quantity': 1,
            }],
            mode='payment',
            success_url=settings.STRIPE_SUCCESS_URL,
            cancel_url=settings.STRIPE_CANCEL_URL,
        )
        return JsonResponse({'session_url': session_paiement.url})
    except stripe.error.StripeError as e:
        logger.error(f"Stripe error: {str(e)}")
        return JsonResponse({'error': "Échec du paiement. Réessayez."}, status=500)

@login_required
@csrf_exempt
def success(request):
    """Gère le succès du paiement"""
    commande = Commandes.objects.filter(utilisateur=request.user, statut='pending').last()
    if commande:
        commande.statut = 'shipped'
        commande.save()
        Paiements.objects.create(
            commande=commande,
            montant=commande.total,
            methode_paiement='stripe',
            statut='completed'
        )
    return JsonResponse({'message': 'Paiement réussi'})

@login_required
@csrf_exempt
def cancel(request):
    """Gère l'annulation du paiement"""
    return JsonResponse({'message': 'Paiement annulé'})

@login_required
@csrf_exempt
@check_empty_cart
def checkout(request):
    """Prépare la page de paiement"""
    panier = get_user_cart(request.user)
    articles = [
        {
            'produit_id': item.produit.id,
            'nom': item.produit.nom,
            'quantite': item.quantite,
            'prix': item.produit.prix,
        }
        for item in panier.articles.all()
    ]

    return JsonResponse({
        'stripe_public_key': settings.STRIPE_PUBLISHABLE_KEY,
        'articles': articles,
        'prix_total': panier.calculer_total(),
    })
