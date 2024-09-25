from django import forms
from .models.models_commande import Commandes

class CommandeForm(forms.ModelForm):
    STATUT_CHOICES = (
        ('pending', 'En attente'),
        ('shipped', 'Expédié'),
        ('cancelled', 'Annulé'),
    )

    statut = forms.ChoiceField(choices=STATUT_CHOICES, label="Statut de la commande")

    class Meta:
        model = Commandes
        fields = ['statut', 'total']
        widgets = {
            'total': forms.HiddenInput(),
        }

    def __init__(self, *args, **kwargs):
        super(CommandeForm, self).__init__(*args, **kwargs)
        self.fields['statut'].initial = 'pending'

    def clean_total(self):
        total = self.cleaned_data.get('total')
        if total <= 0:
            raise forms.ValidationError("Le total doit être supérieur à 0.")
        return total

    def clean_statut(self):
        statut = self.cleaned_data.get('statut')
        if statut not in dict(self.STATUT_CHOICES):
            raise forms.ValidationError("Statut invalide. Veuillez choisir un statut parmi 'En attente', 'Expédié' ou 'Annulé'.")
        return statut