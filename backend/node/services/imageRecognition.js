import vision from '@google-cloud/vision';
const client = new vision.ImageAnnotatorClient({
    keyFilename: './config/vision-api-key.json' // Chemin vers ton fichier de clé JSON
});

// Fonction pour analyser une image
export async function analyzeImage(imagePath) {
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
