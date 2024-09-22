const express = require('express');
const app = express();

const { sendNotification } = require('./aws-sns-service');

app.use(express.json());

app.post('/send-notification/sns', (req, res) => {
  const { topicArn, message } = req.body;
  sendNotification(topicArn, message);
  res.send('Notification sent via SNS');
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
