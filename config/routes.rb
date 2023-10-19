Rails.application.routes.draw do
  resources :checkout do
    collection do
      get "success"
      get "cancel"
    end
  end


  root "checkout#new"
end
