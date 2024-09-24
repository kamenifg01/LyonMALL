

from django.test import TestCase
from django.contrib.auth.models import User
from .models import Commandes, Produits, CommandeProduits
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

        # Simuler un panier avec un produit
        session = self.client.session
        session['cart'] = [{'product_id': self.produit.id, 'quantity': 1}]
        session.save()

        # Soumettre le formulaire de commande avec les champs nécessaires
        response = self.client.post(reverse('creer_commande'), {
            'statut': 'pending',  # Champ statut ajouté
            'total': 100,  # Assurez-vous que tous les champs requis sont inclus
        })

        # Debug : afficher le contenu de la réponse pour comprendre le problème
        #print(response.content)

        # Vérifier la redirection correcte
        self.assertEqual(response.status_code, 302)  # Redirection attendue vers la page de suivi
        self.assertEqual(Commandes.objects.count(), 2)  # Une nouvelle commande devrait être créée

    def test_suivre_commande(self):
        self.client.login(username='testuser', password='testpass')
        response = self.client.get(reverse('suivre_commande', args=[self.commande.id]))
        
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Test Produit')  # Le produit doit être affiché
        self.assertContains(response, 'pending')  # Le statut doit être affiché

    def test_annuler_commande(self):
        self.client.login(username='testuser', password='testpass')
        response = self.client.post(reverse('annuler_commande', args=[self.commande.id]))
        
        self.assertEqual(response.status_code, 302)
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
