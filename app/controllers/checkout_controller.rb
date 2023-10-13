class CheckoutController < ApplicationController
  def new
    if params[:success]
      redirect_to root_path, flash: { success: "Checkout created successfully!" }
    else
      redirect_to root_path, flash: { error: "Sorry to see you cancel." }
    end
  end

  def create
    @session = Stripe::Checkout::Session.create({
      line_items: [{
        price: params.fetch("price"),
        quantity: 1,
      }],
      mode: "payment",
      success_url: new_checkout_url + "?success=true",
      cancel_url: new_checkout_url,
    })

    # BUG: url gets truncated during redirect in codespaces because of fragment identifier "#"
    # redirect_to @session.url, allow_other_host: true
    render inline: "<script>window.location = '<%= @session.url %>'</script>"
  end
end
