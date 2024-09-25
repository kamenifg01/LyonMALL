from django.test import TestCase
from django.contrib.auth.models import User
from lyonmall.models.models_commande import Commandes, Produits, CommandeProduits
from django.urls import reverse

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
