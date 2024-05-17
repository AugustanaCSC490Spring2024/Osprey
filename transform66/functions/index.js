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

const db = admin.firestore();

exports.newDay = functions.pubsub.schedule('* * * * *').timeZone('America/Chicago').onRun(async (context) => {
    db.collection("users").get().then(async snapshot => {
        snapshot.forEach(doc => {
            var email = doc.id;
            var userCompletedToday = doc.data().completedToday;
            var userCompletedYesterday = doc.data().completedYesterday;
            var userDay = doc.data().day;
            var userTarget = doc.data().target;

            if (userCompletedYesterday!=userTarget) {
                db.collection("users").doc(email).update({"status":"fail"});
            }
            else if (userDay==3) {
                db.collection("users").doc(email).update({"status":"success"});
            }
            else {
                db.collection("users").doc(email).update({"completedYesterday":userCompletedToday,"completedToday":0,"day":admin.firestore.FieldValue.increment(1)});
                db.collection("users").doc(email).collection("tasks").get().then(snapshot => {
                    snapshot.forEach(doc => {
                        var task = doc.id;
                        db.collection("users").doc(email).collection("tasks").doc(task).update({"isCompleted":false});
                    })
                });
            }
        })
    });
});

exports.sendReminder = functions.pubsub.schedule('0 23 * * *').timeZone('America/Chicago').onRun(async (context) => {
    
    // Delete old clutter in firebase
    db.collection("mail").listDocuments().then(val => {
        val.map((val) => {
            val.delete();
        })
    });

    // Send an email to each user who has the setting turned on
    // Assuming they haven't failed and they haven't yet finished
    db.collection("users").get().then(snapshot => {
        snapshot.forEach(doc => {
            var email = doc.id;
            var userCompletedToday = doc.data().completedToday;
            var userTarget = doc.data().target;
            var userEmailMe = doc.data().emailMe;
            var userStatus = dod.data().userStatus;
            if (userCompletedToday!=userTarget&&userEmailMe&&userStatus=="working") {
                db.collection("mail").add({"to":[email],"message":{"subject":"Reminder","text":"Don't forget to do your tasks!"}});
            }
        })
    });
});