// backend/node/app.js

import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import sequelize from './config/database.js';  // Utilise .js pour les imports relatifs
import notificationRoutes from './routes/notificationRoutes.js';  // Assure-toi que le fichier utilise bien .js

const app = express();

app.use(cors());
app.use(bodyParser.json());

app.use('/api/notifications', notificationRoutes);

sequelize.sync()
  .then(() => console.log('Base de données synchronisée'))
  .catch((err) => console.log('Erreur lors de la synchronisation de la base de données :', err));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Le serveur est démarré sur le port ${PORT}`);
});

export default app;
