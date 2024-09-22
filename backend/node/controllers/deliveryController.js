import Delivery from '../models/deliveryModel.js';
import DeliveryProvider from '../models/deliveryProviderModel.js';


export const assignDelivery = async (req, res) => {
  const { orderId, providerId } = req.body;

  try {
    const delivery = await Delivery.create({ orderId, providerId });
    res.status(201).json({ message: 'Livraison assignée', delivery });
  } catch (error) {
    res.status(500).json({ message: 'Erreur lors de l’assignation de la livraison', error });
  }
};

export const trackDelivery = async (req, res) => {
  const { trackingNumber } = req.params;

  try {
    const delivery = await Delivery.findOne({ where: { trackingNumber } });
    if (!delivery) {
      return res.status(404).json({ message: 'Livraison non trouvée' });
    }
    res.json(delivery);
  } catch (error) {
    res.status(500).json({ message: 'Erreur lors du suivi de la livraison', error });
  }
};