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
exports.ajouterCategorie = async (nom, description) => {
    const query = `
    INSERT INTO categories (nom, description)
    VALUES ($1, $2) RETURNING *;
  `;
    const values = [nom, description];
    try {
        const res = await client.query(query, values);
        console.log("Catégorie ajoutée:", res.rows[0]);
    } catch (err) {
        console.error("Erreur lors de l'ajout de la catégorie:", err);
    }
};

// Modifier une catégorie
exports.modifierCategorie = async (categorie_id, nom, description) => {
    const query = `
    UPDATE categories 
    SET nom = $1, description = $2
    WHERE categorie_id = $3 RETURNING *;
  `;
    const values = [nom, description, categorie_id];
    try {
        const res = await client.query(query, values);
        console.log("Catégorie modifiée:", res.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la modification de la catégorie:", err);
    }
};

// Supprimer une catégorie
exports.supprimerCategorie = async (categorie_id) => {
    const query = `
    DELETE FROM categories WHERE categorie_id = $1 RETURNING *;
  `;
    const values = [categorie_id];
    try {
        const res = await client.query(query, values);
        console.log("Catégorie supprimée:", res.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la suppression de la catégorie:", err);
    }
};

// Lire les catégories
exports.getCategories = async () => {
    try {
        const res = await client.query('SELECT * FROM categories');
        console.log(res.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des catégories:', err);
    }
};
