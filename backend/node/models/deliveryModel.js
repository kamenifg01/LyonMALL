import { DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

const Delivery = sequelize.define('Delivery', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  orderId: { type: DataTypes.INTEGER, allowNull: false },
  providerId: { type: DataTypes.INTEGER, allowNull: false },
  status: { type: DataTypes.STRING, defaultValue: 'Pending' },
  trackingNumber: { type: DataTypes.STRING, allowNull: true },
});

module.exports = Delivery;