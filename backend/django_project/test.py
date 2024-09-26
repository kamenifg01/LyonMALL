from django.test import TestCase
from django.contrib.auth.models import User
from lyonmall.models.models_commande import Commandes, Produits, CommandeProduits, Panier, ArticlePanier
from django.urls import reverse
from django.conf import settings
import stripe
from unittest.mock import patch

stripe.api_key = settings.STRIPE_SECRET_KEY


class CommandeTests(TestCase):

    def setUp(self):
        # Créer un utilisateur pour les tests
        self.user = User.objects.create_user(username='testuser', password='testpass')
        
        # Créer un produit pour les tests
        self.produit = Produits.objects.create(nom='Test Produit', prix=100, quantite=10)
        
        # Créer une commande pour les tests
        self.commande = Commandes.objects.create(
            utilisateur=self.user,
            statut='pending',
            total=100
        )
        CommandeProduits.objects.create(
            commande=self.commande,
            produit=self.produit,
            quantite=1
        )
        self.commande.recalculer_total()

    def test_creer_commande(self):
        self.client.login(username='testuser', password='testpass')

        # Simuler un panier avec un produit dans la session
        session = self.client.session
        session['cart'] = [{'product_id': self.produit.id, 'quantity': 1}]
        session.save()
        # Ajouter un produit au panier
        response_ajout = self.client.post(reverse('ajouter_au_panier', args=[self.produit.id]))
        self.assertEqual(response_ajout.status_code, 200)
        # Soumettre la création de la commande
        response = self.client.post(reverse('creer_commande'), {
            'statut': 'pending',
            'total': 100,
        })
        # Debug : Afficher le contenu de la réponse pour plus de détails
        print("Response content:", response.content)
        # Vérifier la redirection correcte
        self.assertEqual(response.status_code, 200)  # Vérifier que la commande est créée
        self.assertEqual(Commandes.objects.count(), 2)  # Une nouvelle commande doit être créée
        self.assertEqual(response.json()['message'], 'Commande créée')

    def test_suivre_commande(self):
        self.client.login(username='testuser', password='testpass')
        response = self.client.get(reverse('suivre_commande', args=[self.commande.id]))
        
        self.assertEqual(response.status_code, 200)
        self.assertIn('Test Produit', response.json()['produits'][0]['nom'])  # Vérifier que le produit est affiché
        self.assertEqual(float(response.json()['produits'][0]['prix']), 100.00)  # Vérifier le prix
        self.assertEqual(self.commande.statut, 'pending')  # Le statut doit être affiché

    def test_annuler_commande(self):
        self.client.login(username='testuser', password='testpass')
        response = self.client.post(reverse('annuler_commande', args=[self.commande.id]))
        
        self.assertEqual(response.status_code, 200)
        self.commande.refresh_from_db()
        self.assertEqual(self.commande.statut, 'cancelled')  # Le statut doit être mis à jour

    def test_modifier_quantite_produit(self):
        # Créer un nouveau produit pour le test
        nouveau_produit = Produits.objects.create(nom="Nouveau produit", prix=20.00, quantite=10)

        # Ajouter un nouveau produit à la commande avec une quantité spécifiée
        CommandeProduits.objects.create(commande=self.commande, produit=nouveau_produit, quantite=2)

        # Modifier la quantité d'un produit existant dans la commande
        commande_produit = CommandeProduits.objects.get(commande=self.commande, produit=self.produit)
        commande_produit.quantite = 3
        commande_produit.save()

        # Recalculer le total de la commande
        self.commande.recalculer_total()

        # Recharger la commande depuis la base de données pour vérifier les mises à jour
        self.commande.refresh_from_db()

        # Vérifier que le total est correct
        self.assertEqual(self.commande.total, 340)  # 3 x 100 + 2 x 20 = 340

class PaiementTests(TestCase):
    def test_env_keys(self):
        self.assertTrue(settings.STRIPE_SECRET_KEY)
        self.assertTrue(settings.STRIPE_PUBLISHABLE_KEY)
    
    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.client.login(username='testuser', password='12345')
        self.commande = Commandes.objects.create(utilisateur=self.user, statut='pending', total=100)

@patch('stripe.checkout.Session.create')
def test_checkout(self, mock_stripe_session_create):
    # Simule une réponse Stripe sous forme d'un objet avec une propriété 'url'
    mock_stripe_session_create.return_value = stripe.util.convert_to_stripe_object({
        'id': 'session_123',
        'url': 'https://checkout.stripe.com/pay/session_123'
    })

    response = self.client.post(reverse('checkout', args=[self.commande.id]))
    self.assertEqual(response.status_code, 200)
    self.assertIn('session_url', response.json())
    self.assertEqual(response.json()['session_url'], 'https://checkout.stripe.com/pay/session_123')


class PanierTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.client.login(username='testuser', password='12345')
        self.produit = Produits.objects.create(nom='Produit Test', prix=10, quantite=5)

    def test_modifier_quantite(self):
        # Ajouter un produit au panier
        self.client.post(reverse('ajouter_au_panier', args=[self.produit.id]))
        
        # Modifier la quantité
        response = self.client.post(reverse('modifier_quantite_panier', args=[self.produit.id]), {'quantite': 3})
        self.assertEqual(response.status_code, 200)
        self.assertIn('Quantité mise à jour', response.json()['message'])
        
        # Vérifier que la quantité a été mise à jour dans le panier
        panier = Panier.objects.get(utilisateur=self.user)
        article_panier = ArticlePanier.objects.get(panier=panier, produit=self.produit)
        self.assertEqual(article_panier.quantite, 3)

    def test_vider_panier(self):
        # Ajouter un produit au panier
        self.client.post(reverse('ajouter_au_panier', args=[self.produit.id]))
        
        # Vider le panier
        response = self.client.post(reverse('vider_panier'))
        self.assertEqual(response.status_code, 200)
        self.assertIn('Panier vidé', response.json()['message'])

class RemboursementTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.client.login(username='testuser', password='12345')
        self.commande = Commandes.objects.create(utilisateur=self.user, statut='shipped', total=100, charge_id='ch_123')

    @patch('stripe.Refund.create')
    def test_rembourser_commande(self, mock_stripe_refund_create):
        # Simule une réponse valide de Stripe pour le remboursement
        mock_stripe_refund_create.return_value = {
            'id': 're_123',
            'status': 'succeeded'
        }

        # Créer une commande avec un payment_intent_id valide
        commande = Commandes.objects.create(
            utilisateur=self.user,
            statut='shipped',
            total=100,
            charge_id='ch_123',
            payment_intent_id="pi_test_123456789"
        )

        response = self.client.post(reverse('rembourser_commande', args=[commande.id]))
        print("Response content:", response.content)  # Debug pour afficher le contenu de la réponse en cas d'erreur
        
        self.assertEqual(response.status_code, 200)
        self.assertIn('Commande remboursée', response.json()['message'])
