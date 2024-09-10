const request = require('supertest');
const express = require('express');
const bodyParser = require('body-parser');
const venteController = require('../controllers/venteController');  // Assure-toi que le chemin est correct

const app = express();
app.use(bodyParser.json());

// Définir les routes pour tester
app.post('/ventes', venteController.ajouterVente);
app.get('/ventes', venteController.getVentes);
app.get('/ventes/statistiques/jour', venteController.getVentesParJour);
app.get('/ventes/statistiques/populaires', venteController.getProduitsPopulaires);

describe('venteController', () => {
    let server;

    beforeAll(() => {
        server = app.listen(3002);  // Choisis un port libre pour les tests
    });

    afterAll(() => {
        server.close();
    });

    test('Devrait ajouter une vente', async () => {
        const response = await request(server)
            .post('/ventes')
            .send({
                produit_id: 1,
                quantite: 5
            });

        expect(response.statusCode).toBe(201);
        expect(response.body).toHaveProperty('produit_id', 1);
        expect(response.body).toHaveProperty('quantite', 5);
    });

    // Ajoute d'autres tests pour les opérations de lecture et les statistiques
});
