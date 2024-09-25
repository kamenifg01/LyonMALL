import express from 'express';
import ProduitController from '../controllers/produitController';
const router = express.Router();

// Routes pour gérer les produits
router.post('/', ProduitController.ajouterProduit);
router.put('/:produit_id', ProduitController.modifierProduit);
router.delete('/:produit_id', ProduitController.supprimerProduit);
router.get('/', ProduitController.getProduits);

export default router;
