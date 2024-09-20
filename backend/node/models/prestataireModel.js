// backend/node/models/prestataireModel.js
import { DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

const Prestataire = sequelize.define('Prestataire', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  nom: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  adresse: {
    type: DataTypes.STRING,
    allowNull: false,
  },
}, {
  timestamps: false,
  tableName: 'prestataires_de_livraison',
});

export default Prestataire;
