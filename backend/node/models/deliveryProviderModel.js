const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const DeliveryProvider = sequelize.define('DeliveryProvider', {
  id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  name: { type: DataTypes.STRING, allowNull: false },
  address: { type: DataTypes.STRING, allowNull: false },
});

module.exports = DeliveryProvider;