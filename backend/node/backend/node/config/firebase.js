const admin = require('firebase-admin');
const serviceAccount = require('../../firebase-adminsdk.json'); // Téléchargez ce fichier depuis Firebase Console

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports = admin;
