class CarrinhosController < ApplicationController
  def edit
    @itens = Produto.where(id: 1) || ProcessadorPedido.new(params[:id]).cria_carrega_carrinho
  end

  def update

  end

  private
  def carrinho_params
  end
end
