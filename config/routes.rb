Rails.application.routes.draw do
  devise_for :users

  namespace :webhooks do
    post 'stripe', to: 'stripe#create'
  end

  resources :checkout do
    collection do
      get "success"
      get "cancel"
    end
  end

  get "/billing", to: "billing#portal", as: "billing_portal"

  root "checkout#new"
end
