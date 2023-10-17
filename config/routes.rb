Rails.application.routes.draw do
  resources :checkout do
    collection do
      get "return"
    end
  end


  root "checkout#index"
end
