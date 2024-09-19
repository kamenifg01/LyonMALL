// backend/node/controllers/notificationController.js

import admin from '../config/firebase.js';  // Utilise l'import par défaut pour admin

const messaging = admin.messaging();  // Utilise l'instance Firebase Admin

// Fonction pour envoyer une notification
export const sendNotification = async (req, res) => {
  const { token, message } = req.body;

  try {
    await messaging.send({
      token: token,
      notification: {
        title: 'Nouvelle Notification',
        body: message,
      },
    });

    res.status(200).json({ message: 'Notification envoyée avec succès' });
  } catch (error) {
    console.error('Erreur lors de l\'envoi de la notification:', error);
    res.status(500).json({ message: 'Échec de l\'envoi de la notification' });
  }
};
