const { Client } = require('pg');

const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'BD_lyonmall',
    password: 'admin',
    port: 5432,
});

client.connect();


// AJOUTER PRODUIT
const ajouterProduit = async (nom, description, prix, quantite, categorie_id, image_url) => {
    const query = `
      INSERT INTO produits (nom, description, prix, quantite, categorie_id, image_url)
      VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;
    `;
    const values = [nom, description, prix, quantite, categorie_id, image_url];
    try {
        const res = await client.query(query, values);
        console.log("Produit ajouté:", res.rows[0]);
    } catch (err) {
        console.error("Erreur lors de l'ajout du produit:", err);
    }
};

/*
// Exemple d'appel de la fonction pour ajouter un produit
ajouterProduit('Produit Test', 'Une description', 19.99, 100, 1, 'http://image.url/test.jpg');
// Exemple d'ajout d'un produit
addProduct('Nouveau Produit', 'Description du produit', 29.99, 1);
*/


// MODIFIER PRODUIT
const modifierProduit = async (produit_id, nom, description, prix, quantite, categorie_id, image_url) => {
    const query = `
      UPDATE produits 
      SET nom = $1, description = $2, prix = $3, quantite = $4, categorie_id = $5, image_url = $6
      WHERE produit_id = $7 RETURNING *;
    `;
    const values = [nom, description, prix, quantite, categorie_id, image_url, produit_id];
    try {
        const res = await client.query(query, values);
        console.log("Produit modifié:", res.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la modification du produit:", err);
    }
};

/*
  // Exemple d'appel de la fonction pour modifier un produit
  modifierProduit(1, 'Produit Modifié', 'Nouvelle description', 24.99, 50, 1, 'http://image.url/modifie.jpg');
*/


// SUPPRIMER PRODUIT
const supprimerProduit = async (produit_id) => {
    const query = `
      DELETE FROM produits WHERE produit_id = $1 RETURNING *;
    `;
    const values = [produit_id];
    try {
        const res = await client.query(query, values);
        console.log("Produit supprimé:", res.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la suppression du produit:", err);
    }
};

/*
// Exemple d'appel de la fonction pour supprimer un produit
supprimerProduit(1); // Remplace 1 par l'ID du produit à supprimer
*/

// RECUPERER TOUT LES PRODUITS
const getProduits = async () => {
    try {
        const res = await client.query('SELECT * FROM produits');
        console.log(res.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des produits:', err);
    }
};

/*
// Exemple d'appel pour récupérer les produits
getProduits();
*/
