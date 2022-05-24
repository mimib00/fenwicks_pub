const functions = require("firebase-functions");
const stripe = require("stripe")(
  "sk_test_51L2iF5BCBx7eZ7I9MbvAUXzMu4SYPZJheUHQVePhZOhEFonUJvJAXnTOBZtnu6KzEJKxIkKmlGFK0MSiUqIJVxsP00huolDtne"
);

exports.stripePaymentIntentrequest = functions
  .region("europe-west1")
  .https.onRequest(async (req, res) => {
    console.log(req.body);
    console.log(req.body.amount);
    console.log(typeof req.body.amount);
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
