import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import path from 'path';
import multer from 'multer';
import fs from 'fs';
import sequelize from './config/database.js';  // Utilise .js pour les imports relatifs

// Importation des routes
import notificationRoutes from './routes/notificationRoutes.js'; 
import livraisonRoutes from './routes/livraisonRoutes.js';
import userRoutes from './routes/userRoutes.js';
import categorieRoutes from './routes/categorieRoutes.js';
import produitRoutes from './routes/produitRoutes.js';
import venteRoutes from './routes/venteRoutes.js';
import { analyzeImage } from './services/imageRecognition.js';  // Import du fichier imageRecognition

// Initialisation de l'application Express
const app = express();

// Middlewares
app.use(cors());
app.use(bodyParser.json());

// Configuration de Multer pour le téléchargement des images
const upload = multer({ dest: 'uploads/' });

// Routes API
app.use('/api/notifications', notificationRoutes);
app.use('/api/livraisons', livraisonRoutes);
app.use('/api/users', userRoutes);
app.use('/api/categories', categorieRoutes);
app.use('/api/produits', produitRoutes);
app.use('/api/ventes', venteRoutes);

// Route pour uploader et analyser une image
app.post('/api/analyze-image', upload.single('image'), async (req, res) => {
    const imagePath = path.join(__dirname, 'uploads', req.file.filename);

    try {
        const labels = await analyzeImage(imagePath);
        fs.unlinkSync(imagePath);  // Supprimer le fichier après traitement
        res.json({ labels });
    } catch (err) {
        console.error("Erreur lors de l'analyse de l'image :", err);
        res.status(500).send('Erreur du serveur');
    }
});

// Synchronisation de la base de données
sequelize.sync()
  .then(() => console.log('Base de données synchronisée'))
  .catch((err) => console.log('Erreur lors de la synchronisation de la base de données :', err));

// Démarrer le serveur
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Le serveur est démarré sur le port ${PORT}`);
});

export default app;
