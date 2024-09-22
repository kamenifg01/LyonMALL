import { DataTypes } from 'sequelize';
import sequelize from '../config/database.js';

const DeliveryProvider = sequelize.define('DeliveryProvider', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  name: { type: DataTypes.STRING, allowNull: false },
  address: { type: DataTypes.STRING, allowNull: false },
});

export default DeliveryProvider;