class CheckoutController < ApplicationController
  def new; end

  def success; end

  def cancel; end

  def create
    session = Stripe::Checkout::Session.create({
      line_items: [{
        price: "price_1O0UaxDs0InRBced8T97Jy1x",
        quantity: 1,
      }],
      mode: 'payment',
      success_url: success_checkout_index_url,
      cancel_url: cancel_checkout_index_url,
    })

    redirect_to session.url, allow_other_host: true
  end
end
