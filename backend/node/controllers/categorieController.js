import connection from "../config/database.js";

// Récupérer toutes les catégories
export const getAllCategories = (req, res) => {
    connection.query("SELECT * FROM categories", (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.json(results.rows); // Utiliser results.rows pour PostgreSQL
        }
    });
};

// Ajouter une catégorie
export const ajouterCategorie = (req, res) => {
    const { nom, description } = req.body;
    const query = `
        INSERT INTO categories (nom, description)
        VALUES ($1, $2) RETURNING *;
    `;
    const values = [nom, description];

    connection.query(query, values, (err, result) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(201).json(result.rows[0]); // Pour PostgreSQL, utiliser result.rows[0]
        }
    });
};

// Modifier une catégorie
export const modifierCategorie = (req, res) => {
    const { categorie_id } = req.params;
    const { nom, description } = req.body;
    const query = `
        UPDATE categories 
        SET nom = $1, description = $2
        WHERE categorie_id = $3 RETURNING *;
    `;
    const values = [nom, description, categorie_id];

    connection.query(query, values, (err, result) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(200).json(result.rows[0]); // Pour PostgreSQL, utiliser result.rows[0]
        }
    });
};

// Supprimer une catégorie
export const supprimerCategorie = (req, res) => {
    const { categorie_id } = req.params;
    const query = `
        DELETE FROM categories WHERE categorie_id = $1 RETURNING *;
    `;
    const values = [categorie_id];

    connection.query(query, values, (err, result) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(200).json(result.rows[0]); // Pour PostgreSQL, utiliser result.rows[0]
        }
    });
};

// Lire les catégories
export const lireCategories = (req, res) => {
    connection.query('SELECT * FROM categories', (err, result) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(200).json(result.rows); // Utiliser result.rows pour PostgreSQL
        }
    });
};
