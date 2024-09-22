from django.db import models
from django.contrib.auth import get_user_model
from django.contrib.auth.models import User



class PrestataireDeLivraison(models.Model):
    prestataire_id = models.AutoField(primary_key=True)
    nom = models.CharField(max_length=100)
    adresse = models.TextField()
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='prestataire')  # Relation avec le modèle User

    def s_identifier(self):
        # Implémentez l'identification du prestataire
        pass

    def afficher_commandes_a_livrer(self):
        # Implémentez l'affichage des commandes à livrer
        return Commande.objects.filter(statut='En attente')

    def optimiser_trajet(self, commandes):
        # Implémentez l'optimisation du trajet
        return "Trajet optimisé"

    def notifier_client(self, commande_id):
        # Implémentez la notification au client
        pass

    def recevoir_commande(self, commande):
        # Implémentez la réception de commande
        pass

    def gerer_livraison(self, commande):
        # Implémentez la gestion de livraison
        pass

    def suivre_colis(self, colis_id):
        # Implémentez le suivi du colis
        return "Suivi du colis"

    def __str__(self):
        return self.nom


class Client(models.Model):
    ROLE_CHOICES = [
        ('admin', 'Administrateur'),
        ('livreur', 'Livreur'),
        ('client', 'Client'),
    ]

    nom = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    mot_de_passe = models.CharField(max_length=255)  # Assurez-vous de ne pas stocker les mots de passe en clair
    adresse = models.TextField()
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default='client')

    def __str__(self):
        return self.nom
    

class Commande(models.Model):
    id = models.AutoField(primary_key=True)
    utilisateur = models.ForeignKey(Client, null=True, on_delete=models.CASCADE)
    date_commande = models.DateField()
    statut = models.CharField(max_length=50)
    total = models.DecimalField(max_digits=10, decimal_places=2)

    def calculer_total(self):
        # Implémentez le calcul du total si nécessaire
        return self.total

    def __str__(self):
        return f"Commande {self.id}"


class Livraison(models.Model):
    id = models.AutoField(primary_key=True)
    commande_id = models.ForeignKey(Commande, on_delete=models.CASCADE)
    prestataire_id = models.ForeignKey(PrestataireDeLivraison, on_delete=models.CASCADE)
    statut_livraison = models.CharField(max_length=50)
    numero_suivi = models.CharField(max_length=100)
    date_envoi = models.DateField()
    date_livraison = models.DateField(null=True, blank=True)

    def suivre_livraison(self):
        # Implémentez le suivi de livraison
        pass

    def __str__(self):
        return f"Livraison {self.id}"
