import express from 'express';
import CategorieController from '../controllers/categorieController';
const router = express.Router();

// Routes pour gérer les catégories
router.post('/', CategorieController.ajouterCategorie);
router.put('/:categorie_id', CategorieController.modifierCategorie);
router.delete('/:categorie_id', CategorieController.supprimerCategorie);
router.get('/', CategorieController.getCategories);

export default router;
