import connection from "../config/database.js"; 

// AJOUTER PRODUIT
export const ajouterProduit = async (req, res) => {
    const { nom, description, prix, quantite, categorie_id, image_url } = req.body;
    connection.query = `
      INSERT INTO produits (nom, description, prix, quantite, categorie_id, image_url)
      VALUES ($1, $2, $3, $4, $5, $6) RETURNING *;
    `;
    const values = [nom, description, prix, quantite, categorie_id, image_url];
    try {
        const result = await client.query(query, values);
        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error("Erreur lors de l'ajout du produit:", err);
        res.status(500).json({ error: 'Erreur lors de l\'ajout du produit.' });
    }
};

// MODIFIER PRODUIT
export const modifierProduit = async (req, res) => {
    const { produit_id } = req.params;
    const { nom, description, prix, quantite, categorie_id, image_url } = req.body;
    connection.query = `
      UPDATE produits 
      SET nom = $1, description = $2, prix = $3, quantite = $4, categorie_id = $5, image_url = $6
      WHERE produit_id = $7 RETURNING *;
    `;
    const values = [nom, description, prix, quantite, categorie_id, image_url, produit_id];
    try {
        const result = await client.query(query, values);
        res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la modification du produit:", err);
        res.status(500).json({ error: 'Erreur lors de la modification du produit.' });
    }
};

// SUPPRIMER PRODUIT
export const supprimerProduit = async (req, res) => {
    const { produit_id } = req.params;
    connection.query = `
      DELETE FROM produits WHERE produit_id = $1 RETURNING *;
    `;
    const values = [produit_id];
    try {
        const result = await client.query(query, values);
        res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error("Erreur lors de la suppression du produit:", err);
        res.status(500).json({ error: 'Erreur lors de la suppression du produit.' });
    }
};

// RECUPERER TOUS LES PRODUITS
export const getProduits = async (req, res) => {
    try {
        const result = await connection.query('SELECT * FROM produits');
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Erreur lors de la récupération des produits:', err);
        res.status(500).json({ error: 'Erreur lors de la récupération des produits.' });
    }
};

// Exportation des fonctions
export { ajouterProduit, modifierProduit, supprimerProduit, getProduits };
