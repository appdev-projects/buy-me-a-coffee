class CheckoutController < ApplicationController
  def new
    @products = Stripe::Product.list(limit: 1, active: true)
  end

  def success; end

  def cancel; end

  def create
    session = Stripe::Checkout::Session.create({
      line_items: [{
        price: params.fetch("price"),
        quantity: 1,
      }],
      mode: 'payment',
      success_url: success_checkout_index_url,
      cancel_url: cancel_checkout_index_url,
    })

    redirect_to session.url, allow_other_host: true
  end
end
