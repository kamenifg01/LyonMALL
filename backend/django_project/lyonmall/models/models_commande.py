from django.db import models
from django.contrib.auth.models import User

# Modèle des produits
class Produits(models.Model):
    nom = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    prix = models.DecimalField(max_digits=10, decimal_places=2)
    quantite = models.IntegerField()
    categorie = models.ForeignKey('Categories', on_delete=models.SET_NULL, null=True)
    image_url = models.URLField(null=True, blank=True)

    def __str__(self):
        return self.nom

# Modèle des catégories
class Categories(models.Model):
    nom = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.nom

# Modèle des commandes
class Commandes(models.Model):
    STATUS_CHOICES = [
        ('pending', 'En attente'),
        ('shipped', 'Expédiée'),
        ('delivered', 'Livrée'),
        ('cancelled', 'Annulée'),
    ]
    utilisateur = models.ForeignKey(User, on_delete=models.CASCADE)
    statut = models.CharField(max_length=50, choices=STATUS_CHOICES, default='pending')
    date_commande = models.DateTimeField(auto_now_add=True)
    total = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)

    def recalculer_total(self):
        total = sum(item.produit.prix * item.quantite for item in self.produits.all())
        self.total = total
        self.save()

    def __str__(self):
        return f"Commande {self.id} - {self.utilisateur.username}"

# Produits associés à une commande
class CommandeProduits(models.Model):
    commande = models.ForeignKey(Commandes, related_name='produits', on_delete=models.CASCADE)
    produit = models.ForeignKey(Produits, on_delete=models.CASCADE)
    quantite = models.IntegerField()

    def __str__(self):
        return f"{self.quantite} x {self.produit.nom}"

# Modèle des paiements
class Paiements(models.Model):
    commande = models.ForeignKey(Commandes, on_delete=models.CASCADE)
    montant = models.DecimalField(max_digits=10, decimal_places=2)
    methode_paiement = models.CharField(max_length=50)
    statut = models.CharField(max_length=50)

    def __str__(self):
        return f"Paiement #{self.id} - Commande {self.commande.id} - Montant: {self.montant}"

# Modèle pour le panier d'achat
class Panier(models.Model):
    utilisateur = models.ForeignKey(User, on_delete=models.CASCADE, related_name='panier')
    date_creation = models.DateTimeField(auto_now_add=True)

    def calculer_total(self):
        return sum(item.calculer_total() for item in self.articles.all())

class ArticlePanier(models.Model):
    panier = models.ForeignKey(Panier, on_delete=models.CASCADE, related_name='articles')
    produit = models.ForeignKey(Produits, on_delete=models.CASCADE)
    quantite = models.PositiveIntegerField(default=1)

    def calculer_total(self):
        return self.produit.prix * self.quantite
