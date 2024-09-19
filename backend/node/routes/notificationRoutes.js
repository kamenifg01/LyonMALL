// backend/node/routes/notificationRoutes.js

import { Router } from 'express';
import { sendNotification } from '../controllers/notificationController.js';  // Utilise .js

const router = Router();

router.post('/', sendNotification);

export default router;
