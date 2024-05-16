/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

// Every day just after midnight, update day
exports.newDay = functions.pubsub.schedule('* * * * *').timeZone('America/Chicago').onRun(async (context) => {
    admin.firestore().collection("users").get().then(snapshot => {
        snapshot.forEach(doc => {
            var userCompletedToday = doc.data().completed_today;
            const userRef = firestore.ref("users/"+doc.id);
            userRef.update({"completed_yesterday":userCompletedToday});
            userRef.update({"completed_today":0});
        })
    });
    return null;
});

// Every day at 11 pm, send an email
exports.sendReminder = functions.pubsub.schedule('0 23 * * *').timeZone('America/Chicago').onRun(async (context) => {
    admin.firestore().collection("users").get().then(snapshot => {
        snapshot.forEach(doc => {
            var email = doc.id;
            var userCompletedToday = doc.data().completed_today;
            var userTarget = doc.data().target;
            if (userCompletedToday!=userTarget) {
                admin.firestore().collection("mail").add({"to":[email],"message":{"subject":"Reminder","text":"Don't forget to do your tasks!"}});
            }
        })
    });
    return null;
});