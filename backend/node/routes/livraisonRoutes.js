// backend/node/routes/livraisonRoutes.js
import { Router } from 'express';
import { assignerLivraison, suivreLivraison } from '../controllers/livraisonController.js';

const router = Router();

// Route pour assigner une commande à un prestataire de livraison
router.post('/assigner', assignerLivraison);

// Route pour suivre une livraison via son numéro de suivi
router.get('/suivre/:numero_suivi', suivreLivraison);

export default router;
