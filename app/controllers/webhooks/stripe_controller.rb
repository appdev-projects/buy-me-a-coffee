class Webhooks::StripeController < ActionController::API
  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV.fetch("STRIPE_ENDPOINT_SECRET")
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      status 400
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      if session.mode == "subscription"
        user = User.find_by(stripe_customer_id: session.customer)
        user.subscriptions.create(
          stripe_subscription_id: session.subscription,
          status: 'active',
          price: session.amount_total
        )
      end
  
    when 'customer.subscription.updated'
      subscription = event.data.object
      user = User.find_by(stripe_customer_id: subscription.customer)
      user_subscription = user.subscriptions.find_by(stripe_subscription_id: subscription.id)
      user_subscription.update(status: subscription.status)
    when 'customer.subscription.deleted'
      subscription = event.data.object
      user = User.find_by(stripe_customer_id: subscription.customer)
      user_subscription = user.subscriptions.find_by(stripe_subscription_id: subscription.id)
      user_subscription.update(status: 'canceled')
    when 'invoice.payment_succeeded'
    when 'invoice.payment_failed'
      # TODO: Handle successful payment, perhaps update the subscription status
      # TODO: Handle payment failures, update the subscription status or notify the user
  
    else
      puts "Unhandled event type: #{event.type}"
    end

    head :ok
  end
end
