const request = require('supertest');
const express = require('express');
const bodyParser = require('body-parser');
const productController = require('../controllers/productController');  // Chemin correct

const app = express();
app.use(bodyParser.json());

// Définir les routes pour tester
app.post('/produits', productController.ajouterProduit);
// Ajoute les autres routes comme put, delete et get pour les produits

describe('productController', () => {
    let server;

    beforeAll(() => {
        server = app.listen(3001);  // Choisis un port libre pour les tests
    });

    afterAll(() => {
        server.close();
    });

    test('Devrait ajouter un produit', async () => {
        const response = await request(server)
            .post('/produits')
            .send({
                nom: 'Produit Test',
                description: 'Description du produit test',
                prix: 99.99,
                quantite: 10,
                categorie_id: 1,
                image_url: 'http://example.com/image.jpg'
            });

        expect(response.statusCode).toBe(201);
        expect(response.body).toHaveProperty('nom', 'Produit Test');
    });

    // Ajoute des tests pour les autres opérations (mise à jour, suppression, etc.)
});
