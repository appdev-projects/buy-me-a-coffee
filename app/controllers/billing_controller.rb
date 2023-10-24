class BillingController < ApplicationController
  before_action :authenticate_user!

  def portal
    session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer.id,
      return_url: root_url,
    })

    redirect_to session.url, allow_other_host: true
  end
end
