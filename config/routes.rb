Rails.application.routes.draw do
  get("checkout/new", action: :new, controller: :checkout, as: "new_checkout")
  get("checkout", action: :create, controller: :checkout, as: "checkout")
  root "home#index"
end
