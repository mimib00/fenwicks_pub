const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")(
  "sk_test_51L2iF5BCBx7eZ7I9MbvAUXzMu4SYPZJheUHQVePhZOhEFonUJvJAXnTOBZtnu6KzEJKxIkKmlGFK0MSiUqIJVxsP00huolDtne"
);

admin.initializeApp();

exports.stripePaymentIntentrequest = functions
  .region("europe-west1")
  .https.onRequest(async (req, res) => {
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
  });

exports.sendNotification = functions
  .region("europe-west1")
  .https.onRequest(async (req, res) => {
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
exports.orderNotification = functions
  .region("europe-west1")
  .firestore.document("orders/{docId}")
  .onUpdate(async (change, context) => {
    var db = admin.firestore();
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
  });
