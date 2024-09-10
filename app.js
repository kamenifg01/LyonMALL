const express = require('express');
const multer = require('multer');
const path = require('path');
const visionClient = require('./imageRecognition');

const CategorieController = require('./controllers/categorieController');
const VentesController = require('./controllers/venteController');

const app = express();
const upload = multer({ dest: 'uploads/' });
app.use(express.json());

// Route pour ajouter une catégorie
app.post('/categories', async (req, res) => {
    const { nom, description } = req.body;
    await CategorieController.ajouterCategorie(nom, description);
    res.send('Catégorie ajoutée');
});

// Route pour modifier une catégorie
app.put('/categories/:id', async (req, res) => {
    const { id } = req.params;
    const { nom, description } = req.body;
    await CategorieController.modifierCategorie(id, nom, description);
    res.send('Catégorie modifiée');
});

// Route pour supprimer une catégorie
app.delete('/categories/:id', async (req, res) => {
    const { id } = req.params;
    await CategorieController.supprimerCategorie(id);
    res.send('Catégorie supprimée');
});

// Route pour récupérer les catégories
app.get('/categories', async (req, res) => {
    const categories = await CategorieController.getCategories();
    res.json(categories);
});

// Routes pour les ventes
app.post('/ventes', VentesController.ajouterVente);
app.get('/ventes', VentesController.getVentes);

// Routes pour les statistiques
app.get('/statistiques/ventes-par-jour', VentesController.getVentesParJour);
app.get('/statistiques/produits-populaires', VentesController.getProduitsPopulaires);

// Route pour uploader et analyser une image
app.post('/analyze-image', upload.single('image'), async (req, res) => {
    const imagePath = path.join(__dirname, 'uploads', req.file.filename);

    try {
        const labels = await visionClient.analyzeImage(imagePath);
        fs.unlinkSync(imagePath); // Supprimer le fichier après traitement
        res.json({ labels });
    } catch (err) {
        res.status(500).send('Erreur du serveur');
    }
});

// Démarrer le serveur
app.listen(3000, () => {
    console.log('Serveur démarré sur le port 3000');
});
