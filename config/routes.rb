Rails.application.routes.draw do
  devise_for :users

  resources :checkout do
    collection do
      get "success"
      get "cancel"
    end
  end


  root "checkout#new"
end
