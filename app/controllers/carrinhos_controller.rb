class CarrinhosController < ApplicationController
  before_action :checa_estoque
  before_action :carrega_preco_total

  def index
    @pedido = Pedido.new
    @itens = ProcessadorPedido.new(@pedido, session[:carrinho]).carrega_carrinho
    @pagamento = {tipo: 'débito', tipo_pagamento_id: 0},{tipo: 'crédito', tipo_pagamento_id: 1}
  end

  private
  def carrinho_params
  end

  def checa_estoque
    true
  end

  def carrega_preco_total
    @soma = Pedido.new().total_pedido(session[:carrinho])
  end
end
