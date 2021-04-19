class PedidosController < ApplicationController

  def new
    @pedido = Pedido.new(tipo_pagamento_id: params[:tipo_pagamento_id])
    @metodo = params[:tipo_pagamento_id] == '1' ? 'crédito' : 'débito'
  end

  def create
    @pedido = Pedido.new(pedido_params)
    transacao = ProcessadorPedido.new(@pedido, session[:carrinho])
    if transacao.processar
      session[:carrinho] = []
      redirect_to pedido_path(@pedido)
    else
      redirect_to carrinhos_path
    end
  end

  def show; end

    private

    def pedido_params
      params.require(:pedido).permit(:tipo_pagamento_id)
    end
end