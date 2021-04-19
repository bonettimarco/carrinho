Rails.application.routes.draw do

  root 'produtos#index'
  resources :produtos, only: :index
  post 'produtos/por_no_carrinho/:id', to: 'produtos#por_no_carrinho', as: 'por_no_carrinho'
  delete 'produtos/remover_do_carrinho', to: 'produtos#remover_do_carrinho', as: 'remover_do_carrinho'
  resources :carrinhos
  resources :pedidos, only: [:index, :show, :create]
  get 'pedidos/new/:tipo_pagamento_id', to: 'pedidos#new#tipo_pagamento_id', as: 'new_pedido'

end
