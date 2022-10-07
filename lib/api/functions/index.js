const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")(
  "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"
);

admin.initializeApp();

async function addNotification(userId, notification) {
  try {
    var db = admin.firestore();
    if (userId == null) {
      await db
        .collection("users")
        .get()
        .then((snap) => {
          snap.forEach((doc) => {
            doc.ref.set(
              {
                notifications:
                  admin.firestore.FieldValue.arrayUnion(notification),
              },
              { merge: true }
            );
          });
        });
    } else {
      await db
        .collection("users")
        .doc(userId)
        .set(
          {
            notifications: admin.firestore.FieldValue.arrayUnion(notification),
          },
          { merge: true }
        );
    }
  } catch (error) {
    console.log(error);
  }
}

exports.getUserStatus = functions.https.onRequest(async (req, res) => {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Content-Type");

  const uid = req.body.uid;
  const auth = admin.auth();
  
  try {
    const user = await auth.getUser(uid);

    res.status(200).send({ disabled: user.disabled });
  } catch (error) {
    res.status(404).send({  error: error.message });
  }
});

exports.stripePaymentIntentrequest = functions.https.onRequest(
  async (req, res) => {
    try {
      let customerId;

      //Gets the customer who's email id matches the one sent by the client
      const customerList = await stripe.customers.list({
        email: req.body.email,
        limit: 1,
      });

      //Checks the if the customer exists, if not creates a new customer
      if (customerList.data.length !== 0) {
        customerId = customerList.data[0].id;
      } else {
        const customer = await stripe.customers.create({
          email: req.body.email,
        });
        customerId = customer.data.id;
      }

      //Creates a temporary secret key linked with the customer
      const ephemeralKey = await stripe.ephemeralKeys.create(
        { customer: customerId },
        { apiVersion: "2020-08-27" }
      );

      //Creates a new payment intent with amount passed in from the client
      const paymentIntent = await stripe.paymentIntents.create({
        amount: req.body.amount,
        currency: "usd",
        customer: customerId,
      });

      res.status(200).send({
        paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: customerId,
        success: true,
      });
    } catch (error) {
      res.status(404).send({ success: false, error: error.message });
    }
  }
);

exports.sendNotification = functions.https.onRequest(async (req, res) => {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  try {
    const token = req.body.token;
    const amount = req.body.amount;

    const payload = {
      notification: {
        title: "Gifted",
        body: `You have reccived ${amount} points`,
      },

      token: String(token),
    };

    await admin.messaging().send(payload);
    res.sendStatus(200);
  } catch (error) {
    res.status(404).send({ success: false, error: error.message });
  }
});

// listen to when an order status change it send a notification to the user.
exports.orderNotification = functions.firestore
  .document("orders/{docId}")
  .onUpdate(async (change, context) => {
    const doc = context.params.docId;
    const data = change.after.data();

    const user = await data.owner.get();

    const payload = {
      notification: {
        title: "Order Status",
        body: `Order N: ${doc} is ${data.status}`,
      },
      token: user.data().token,
    };

    await admin.messaging().send(payload);

    const notification = {
      title: "Order Status",
      message: `Order N: ${doc} is ${data.status}`,
      createdAt: admin.firestore.Timestamp.now(),
      order: doc,
    };
    await addNotification(user.id, notification);
  });

exports.sendNotifications = functions.https.onRequest(async (req, res) => {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  try {
    const title = req.body.title;
    const body = req.body.body;

    const payload = {
      notification: {
        title: title,
        body: body,
      },
      topic: "all",
    };
    await admin.messaging().send(payload);
    const notification = {
      title: title,
      message: body,
      createdAt: admin.firestore.Timestamp.now(),
      order: null,
    };
    await addNotification(null, notification);
    res.sendStatus(200);
  } catch (error) {
    res.status(404).send({ success: false, error: error.message });
  }
});

exports.notifyAdmin = functions.firestore
  .document("orders/{docId}")
  .onCreate(async (change, context) => {
    var db = admin.firestore();
    const doc = context.params.docId;
    try {
      const snapshot = await db.collection("admins").get();
      const adminUser = snapshot.docs[0].data();
      const token = adminUser.token;

      const payload = {
        notification: {
          title: "New Order",
          body: `A new order has been placed`,
        },
        token: token,
      };
      await admin.messaging().send(payload);
      await db
        .collection("admins")
        .doc(snapshot.docs[0].id)
        .update({
          notifications: admin.firestore.FieldValue.arrayUnion(doc),
        });
    } catch (error) {
      console.log(error);
    }
  });

exports.deleteUser = functions.https.onRequest(async (req, res) => {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  try {
    const uid = req.body.uid;
    const db = admin.firestore();
    const auth = admin.auth();

    await auth.deleteUser(uid);

    res.sendStatus(200);
  } catch (error) {
    console.log(error);
    res.sendStatus(400);
  }
});
