class PedidosController < ApplicationController

  def create
    @pedido = Pedido.new(pedido_params)
    transacao = ProcessadorPedido.new(@pedido, session[:carrinho])
    if transacao.processar
      session[:carrinho] = []
      redirect_to pedido_path(@pedido)
    else
      redirect_to carrinhos_path, notice: "Falha no processamento, tente novamente mais tarde"
    end
  end

  def show
    @pedido = Pedido.find(params[:id])
  end

    private

    def pedido_params
      params.require(:pedido).permit(:tipo_pagamento_id)
    end
end