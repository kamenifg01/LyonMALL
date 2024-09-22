// backend/node/config/firebase.js

import admin from 'firebase-admin';
import { readFileSync } from 'fs';  // Utilisation de fs pour lire le fichier JSON
import { resolve } from 'path';  // Pour obtenir le chemin absolu du fichier

const serviceAccountPath = resolve('../../backend/node/config/lyonmall-firebase-adminsdk-a9ozx-64c3b45018.json');
const serviceAccount = JSON.parse(readFileSync(serviceAccountPath, 'utf8'));  // Lire le fichier JSON

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

export default admin;
