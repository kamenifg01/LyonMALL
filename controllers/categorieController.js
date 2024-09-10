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

// Ajouter une catégorie
const ajouterCategorie = async (req, res) => {
    const { nom, description } = req.body;
    const query = `
        INSERT INTO categories (nom, description)
        VALUES ($1, $2) RETURNING *;
    `;
    const values = [nom, description];
    try {
        const result = await client.query(query, values);
        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error("Erreur lors de l'ajout de la catégorie:", err);
        res.status(500).json({ error: 'Erreur lors de l\'ajout de la catégorie.' });
    }
};

// Modifier une catégorie
const modifierCategorie = async (req, res) => {
    const { categorie_id } = req.params;
    const { nom, description } = req.body;
    const query = `
        UPDATE categories 
        SET nom = $1, description = $2
        WHERE categorie_id = $3 RETURNING *;
    `;
    const values = [nom, description, categorie_id];
    try {
        const result = await client.query(query, values);
        res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la modification de la catégorie:", err);
        res.status(500).json({ error: 'Erreur lors de la modification de la catégorie.' });
    }
};

// Supprimer une catégorie
const supprimerCategorie = async (req, res) => {
    const { categorie_id } = req.params;
    const query = `
        DELETE FROM categories WHERE categorie_id = $1 RETURNING *;
    `;
    const values = [categorie_id];
    try {
        const result = await client.query(query, values);
        res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la suppression de la catégorie:", err);
        res.status(500).json({ error: 'Erreur lors de la suppression de la catégorie.' });
    }
};

// Lire les catégories
const getCategories = async (req, res) => {
    try {
        const result = await client.query('SELECT * FROM categories');
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des catégories:', err);
        res.status(500).json({ error: 'Erreur lors de la récupération des catégories.' });
    }
};

// Exportation des fonctions
module.exports = {
    ajouterCategorie,
    modifierCategorie,
    supprimerCategorie,
    getCategories
};
