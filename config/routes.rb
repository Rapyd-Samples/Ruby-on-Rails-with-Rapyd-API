Rails.application.routes.draw do
  resources :products, only: [:show] do
      post 'create_payment', on: :member
  end

  root "products#index"
end
