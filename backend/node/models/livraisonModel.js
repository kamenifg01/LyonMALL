// backend/node/models/livraisonModel.js
import { DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

const Livraison = sequelize.define('Livraison', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  commande_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  prestataire_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  statut_livraison: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'en attente',
  },
  numero_suivi: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  date_envoi: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
  date_livraison: {
    type: DataTypes.DATE,
    allowNull: true,
  },
}, {
  timestamps: false,
  tableName: 'livraisons',
});

export default Livraison;
