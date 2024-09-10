const { Client } = require('pg');

// Configuration de la connexion à la base de données
const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'BD_lyonmall',
    password: 'admin',
    port: 5432,
});

// Connexion à la base de données
client.connect();

// Ajouter une vente
const ajouterVente = async (req, res) => {
    const { produit_id, quantite } = req.body;
    const query = `
        INSERT INTO ventes (produit_id, quantite, date_vente)
        VALUES ($1, $2, CURRENT_TIMESTAMP) RETURNING *;
    `;
    const values = [produit_id, quantite];
    try {
        const result = await client.query(query, values);
        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error('Erreur lors de l\'ajout de la vente:', err);
        res.status(500).send('Erreur du serveur');
    }
};

// Obtenir toutes les ventes
const getVentes = async (req, res) => {
    const query = `
        SELECT v.vente_id, p.nom AS produit, v.quantite, v.date_vente, p.prix
        FROM ventes v
        JOIN produits p ON v.produit_id = p.produit_id;
    `;
    try {
        const result = await client.query(query);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des ventes:', err);
        res.status(500).send('Erreur du serveur');
    }
};

// Statistiques : ventes par jour
const getVentesParJour = async (req, res) => {
    const query = `
        SELECT DATE(v.date_vente) AS jour, SUM(v.quantite) AS total_quantite, SUM(p.prix * v.quantite) AS total_ventes
        FROM ventes v
        JOIN produits p ON v.produit_id = p.produit_id
        GROUP BY jour
        ORDER BY jour DESC;
    `;
    try {
        const result = await client.query(query);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des ventes par jour:', err);
        res.status(500).send('Erreur du serveur');
    }
};

// Statistiques : produits les plus vendus
const getProduitsPopulaires = async (req, res) => {
    const query = `
        SELECT p.nom, SUM(v.quantite) AS total_vendu
        FROM ventes v
        JOIN produits p ON v.produit_id = p.produit_id
        GROUP BY p.nom
        ORDER BY total_vendu DESC
        LIMIT 10;
    `;
    try {
        const result = await client.query(query);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des produits populaires:', err);
        res.status(500).send('Erreur du serveur');
    }
};

// Exportation des fonctions
module.exports = {
    ajouterVente,
    getVentes,
    getVentesParJour,
    getProduitsPopulaires,
};
