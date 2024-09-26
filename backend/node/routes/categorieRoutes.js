import express from 'express';
import { ajouterCategorie, modifierCategorie, supprimerCategorie, getAllCategories } from '../controllers/categorieController.js';

const router = express.Router();

// Routes pour gérer les catégories
router.post('/', ajouterCategorie);
router.put('/:categorie_id', modifierCategorie);
router.delete('/:categorie_id', supprimerCategorie);
router.get('/', getAllCategories);

export default router;
