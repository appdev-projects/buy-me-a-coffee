# Members Only
This is a simple demo showing how to accept subscription payments using [Stripe](https://stripe.com).

If you're looking for an alternative/simpler way to accept payments, checkout [Stripe Payment Links](https://stripe.com/payments/payment-links).

[Stripe API Documentation](https://stripe.com/docs/api)

# How It Works

- The `checkout#new` action fetches stripe products `@products = Stripe::Product.list(limit: 1)`
- The `checkout#create` action creates a stripe checkout sesssion and redirects the user to a Stripe checkout page.
- Depending on the checkout, the user will be redirected by Stripe to the `checkout#success` or `checkout#cancel` routes
- Stripe communicates events to the app via the StripeController 'webhook' for things like `checkout.session.completed`. This way we know to create a Subscription record or with an event like `customer.subscription.deleted` update the subscription record status.
- The user can manage their subscription using the `billing#portal` action which redirects to the Stripe billing portal.

## Webhook
You can [listen to Stripe events](https://dashboard.stripe.com/test/webhooks/create) using the [Stripe CLI](https://github.com/stripe/stripe-cli)

```
stripe login
stripe listen --forward-to localhost:3000/webhooks/stripe
```

You can then manually trigger events from the CLI (eg `stripe trigger checkout.session.completed`) or simply wait for Stripe to communicate with your webhook while using the app.


# ENV
Please set these values in your .env file

```
STRIPE_PUBLISHABLE_KEY
STRIPE_SECRET_KEY
STRIPE_ENDPOINT_SECRET
```

# Testing

https://stripe.com/docs/testing

You can use a test credit card number "4242 4242 4242 4242" to purchase a subscription
