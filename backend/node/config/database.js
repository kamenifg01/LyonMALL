// backend/config/database.js
const { Sequelize } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 6969,  // Ajout du port de la base de données
  dialect: 'postgres',
  logging: false,  // Désactiver les logs de requêtes SQL (tu peux le mettre à `true` si tu veux voir les logs)
  pool: {
    max: 5,       // Nombre maximum de connexions dans le pool
    min: 0,       // Nombre minimum de connexions dans le pool
    acquire: 30000, // Temps maximum (en ms) avant d'abandonner une tentative de connexion
    idle: 10000    // Temps maximum (en ms) avant de déconnecter une connexion inactive
  }
});

sequelize.authenticate()
  .then(() => console.log('Connection has been established successfully.'))
  .catch(err => console.error('Unable to connect to the database:', err));

module.exports = sequelize;
