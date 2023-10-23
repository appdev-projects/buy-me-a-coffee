# Buy a Coffee
This is a simple demo showing how to accept payments using stripe

This demo fetches stripe products `@products = Stripe::Product.list(limit: 1)`

[Stripe API Documentation](https://stripe.com/docs/api)

## Webhook
[Listen to Stripe events](https://dashboard.stripe.com/test/webhooks/create)

[Stripe CLI](https://github.com/stripe/stripe-cli)

```
stripe login
stripe listen --forward-to localhost:3000/webhooks/stripe
```

Then you can manually trigger events: `stripe trigger checkout.session.completed`


# ENV
Please set these values in your .env file

```
STRIPE_PUBLISHABLE_KEY
STRIPE_SECRET_KEY
STRIPE_ENDPOINT_SECRET
```

# Testing

https://stripe.com/docs/testing

Test credit card number "4242 4242 4242 4242"
