class HomeController < ApplicationController
  def index
    @products = Stripe::Product.list(limit: 10)
  end
end
