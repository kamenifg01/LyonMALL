import express from 'express';
import VenteController from '../controllers/venteController.js';
const router = express.Router();

// Routes pour gérer les ventes
router.post('/', VenteController.ajouterVente);
router.get('/', VenteController.getVentes);

// Routes pour les statistiques
router.get('/par-jour', VenteController.getVentesParJour);
router.get('/produits-populaires', VenteController.getProduitsPopulaires);

export default router;
