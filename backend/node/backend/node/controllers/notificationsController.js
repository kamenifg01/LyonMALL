const firebaseAdmin = require('../config/firebase');

exports.sendPushNotification = async (req, res) => {
  const { token, message } = req.body;

  const payload = {
    notification: {
      title: "Nouvelle notification",
      body: message,
    },
  };

  try {
    await firebaseAdmin.messaging().sendToDevice(token, payload);
    res.status(200).json({ message: 'Notification envoyée' });
  } catch (error) {
    res.status(500).json({ message: 'Erreur lors de l’envoi de la notification', error });
  }
};
