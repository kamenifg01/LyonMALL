const admin = require('firebase-admin');
const serviceAccount = require('../../lyonmall-firebase-adminsdk-a9ozx-64c3b45018.json'); // Téléchargez ce fichier depuis Firebase Console

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

module.exports = admin;
