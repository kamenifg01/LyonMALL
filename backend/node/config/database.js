// backend/node/config/database.js

import dotenv from 'dotenv';  // Utilise import pour dotenv
dotenv.config();  // Appelle dotenv.config() après l'import

import { Sequelize } from 'sequelize';

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST || '127.0.0.1',
    dialect: 'postgres',
    port: process.env.DB_PORT || 6969,
  }
);

export default sequelize;
