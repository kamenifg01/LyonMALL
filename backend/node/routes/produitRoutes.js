import express from 'express';
import { ajouterProduit, modifierProduit, supprimerProduit, getProduits } from '../controllers/productController.js';

const router = express.Router();

// Routes pour gérer les produits
router.post('/', ajouterProduit);
router.put('/:produit_id', modifierProduit);
router.delete('/:produit_id', supprimerProduit);
router.get('/', getProduits);

export default router;
