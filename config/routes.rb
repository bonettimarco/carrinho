Rails.application.routes.draw do

  resources :produtos, only: :index
  resources :carrinhos, only: [:edit, :update]
  resources :pedidos, only: [:new, :create]

end
