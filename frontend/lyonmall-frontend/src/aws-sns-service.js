const AWS = require('aws-sdk');

AWS.config.update({
 region: 'eu-west-1', // Région Europe West
 accessKeyId: 'YOUR_ACCESS_KEY_ID',
 secretAccessKey: 'YOUR_SECRET_ACCESS_KEY'
});

const sns = new AWS.SNS();

function sendNotification(topicArn, message) {
 const params = {
  Message: message.body,
  Subject: message.title,
  TopicArn: topicArn
 };

 sns.publish(params, (err, data) => {
  if (err) {
   console.error('Error sending notification:', err);
  } else {
   console.log('Notification sent successfully:', data);
  }
 });
}

module.exports = { sendNotification };
