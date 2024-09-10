const vision = require('@google-cloud/vision');
const client = new vision.ImageAnnotatorClient({
    keyFilename: 'path/to/your-service-account-file.json' // Chemin vers ton fichier de clé JSON
});

// Fonction pour analyser une image
async function analyzeImage(imagePath) {
    try {
        const [result] = await client.labelDetection(imagePath);
        const labels = result.labelAnnotations;
        console.log('Labels:');
        labels.forEach(label => console.log(label.description));
        return labels.map(label => label.description);
    } catch (err) {
        console.error('Erreur lors de l\'analyse de l\'image:', err);
    }
}

// Utilisation
analyzeImage('path/to/your/image.jpg').then(labels => {
    // Traiter les labels pour associer à une catégorie
});
