const request = require('supertest');
const express = require('express');
const bodyParser = require('body-parser');
const categorieController = require('../controllers/categorieController');  // Chemin correct

const app = express();
app.use(bodyParser.json());

// Définir les routes pour tester
app.post('/categories', categorieController.ajouterCategorie);
app.put('/categories/:categorie_id', categorieController.modifierCategorie);
app.delete('/categories/:categorie_id', categorieController.supprimerCategorie);
app.get('/categories', categorieController.getCategories);

describe('categorieController', () => {
    let server;

    beforeAll(() => {
        server = app.listen(3001);  // Choisis un port libre pour les tests
    });

    afterAll(() => {
        server.close();
    });

    test('Devrait ajouter une catégorie', async () => {
        const response = await request(server)
            .post('/categories')
            .send({
                nom: 'Catégorie Test',
                description: 'Description de la catégorie test'
            });

        expect(response.statusCode).toBe(201);
        expect(response.body).toHaveProperty('nom', 'Catégorie Test');
    });

    // Ajoute des tests pour les opérations de modification, suppression, et récupération de catégories
});