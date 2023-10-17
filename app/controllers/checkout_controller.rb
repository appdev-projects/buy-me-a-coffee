class CheckoutController < ApplicationController
  def new; end

  def index; end

  def return
    redirect_to root_path, flash: { success: "Checkout created successfully!" }
  end

  def create
    session = Stripe::Checkout::Session.create({
      line_items: [{
        price: "price_1O0UaxDs0InRBced8T97Jy1x",
        quantity: 1,
      }],
      mode: "payment",
      ui_mode: "embedded",
      return_url: return_checkout_index_url + "?session_id={CHECKOUT_SESSION_ID}"
    })
  
    render json: {clientSecret: session.client_secret}
  end
end
