/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const admin = require('firebase-admin');
const {onObjectFinalized} = require("firebase-functions/v2/storage");
const vision = require("@google-cloud/vision");

admin.initializeApp(); 
const client = new vision.ImageAnnotatorClient();

exports.processScreenshot = onObjectFinalized(async event => {
    const fileBucket = event.data.bucket;
    const fileName = event.data.name;

    const [result] = await client.textDetection(`gs://${fileBucket}/${fileName}`);
    const detections = result.textAnnotations;
    return admin.firestore().collections("images").doc(fileName).set(detections); 
})

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
