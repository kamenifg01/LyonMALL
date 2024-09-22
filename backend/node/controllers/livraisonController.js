// backend/node/controllers/livraisonController.js
import Livraison from '../models/livraisonModel.js';
import Prestataire from '../models/prestataireModel.js';

// Assigner une commande à un prestataire de livraison
export const assignerLivraison = async (req, res) => {
  const { commande_id, prestataire_id } = req.body;

  try {
    // Vérification de l'existence du prestataire
    const prestataire = await Prestataire.findByPk(prestataire_id);
    if (!prestataire) {
      return res.status(404).json({ message: 'Prestataire non trouvé' });
    }

    // Création de la livraison
    const nouvelleLivraison = await Livraison.create({
      commande_id,
      prestataire_id,
      statut_livraison: 'en cours',
      numero_suivi: `TRACK-${commande_id}-${new Date().getTime()}`,
    });

    res.status(201).json({
      message: 'Livraison assignée avec succès',
      livraison: nouvelleLivraison,
    });
  } catch (error) {
    // Log détaillé de l'erreur pour diagnostic
    console.error('Erreur lors de l\'assignation de la livraison :', error);
    res.status(500).json({
      message: 'Erreur lors de l\'assignation de la livraison',
      error: error.message || 'Erreur inconnue',
    });
  }
};

// Récupérer toutes les livraisons
export const getToutesLivraisons = async (req, res) => {
  try {
    const livraisons = await Livraison.findAll();
    res.status(200).json({
      message: 'Toutes les livraisons récupérées',
      livraisons: livraisons,
    });
  } catch (error) {
    console.error('Erreur lors de la récupération des livraisons :', error);
    res.status(500).json({
      message: 'Erreur lors de la récupération des livraisons',
      error: error.message || 'Erreur inconnue',
    });
  }
};

// Récupérer une livraison par ID
export const getLivraisonById = async (req, res) => {
  const { id } = req.params;

  try {
    const livraison = await Livraison.findByPk(id);
    if (!livraison) {
      return res.status(404).json({ message: 'Livraison non trouvée' });
    }
    res.status(200).json({
      message: 'Livraison récupérée',
      livraison: livraison,
    });
  } catch (error) {
    console.error('Erreur lors de la récupération de la livraison :', error);
    res.status(500).json({
      message: 'Erreur lors de la récupération de la livraison',
      error: error.message || 'Erreur inconnue',
    });
  }
};

// Mettre à jour le statut d'une livraison
export const updateLivraisonStatus = async (req, res) => {
  const { id } = req.params;
  const { statut_livraison } = req.body;

  try {
    const livraison = await Livraison.findByPk(id);
    if (!livraison) {
      return res.status(404).json({ message: 'Livraison non trouvée' });
    } 
    livraison.statut_livraison = statut_livraison;
    await livraison.save();
    res.status(200).json({
      message: 'Statut de la livraison mis à jour',
      livraison: livraison,
    });
  } catch (error) {
    console.error('Erreur lors de la mise à jour du statut de la livraison :', error);
    res.status(500).json({
      message: 'Erreur lors de la mise à jour du statut de la livraison',
      error: error.message || 'Erreur inconnue',
    });
  }
};

// Supprimer une livraison
export const deleteLivraison = async (req, res) => {  
  const { id } = req.params;

  try {
    const livraison = await Livraison.findByPk(id);
    if (!livraison) {
      return res.status(404).json({ message: 'Livraison non trouvée' });
    }
    await livraison.destroy();
    res.status(200).json({
      message: 'Livraison supprimée',
    });
  } catch (error) {
    console.error('Erreur lors de la suppression de la livraison :', error);
    res.status(500).json({
      message: 'Erreur lors de la suppression de la livraison',
      error: error.message || 'Erreur inconnue',
    }); 
  }
};
// Suivre une livraison
export const suivreLivraison = async (req, res) => {
  const { numero_suivi } = req.params;

  try {
    const livraison = await Livraison.findOne({ where: { numero_suivi } });
    
    if (!livraison) {
      return res.status(404).json({ message: 'Livraison non trouvée' });
    }

    res.status(200).json({
      message: 'Informations de suivi de la livraison',
      livraison: {
        id: livraison.id,
        numero_suivi: livraison.numero_suivi,
        statut_livraison: livraison.statut_livraison,
        date_envoi: livraison.date_envoi,
        date_livraison: livraison.date_livraison
      }
    });
  } catch (error) {
    console.error('Erreur lors du suivi de la livraison :', error);
    res.status(500).json({
      message: 'Erreur lors du suivi de la livraison',
      error: error.message || 'Erreur inconnue'
    });
  }
};



