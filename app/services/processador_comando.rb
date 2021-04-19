class ProcessadorComando

  attr_reader :tipo_pagamento, :numero_aprovacao, :valor_recebido, :status_processamento, :pedido, :itens

  def initialize(pedido, itens)
    @pedido = pedido
    @tipo_pagamento = pedido.tipo_pagamento_id
    @numero_aprovacao = ''
    @valor_recebido = 0.00
    @itens = itens
  end

  def processar
    if tipo_pedido_credito?
      @operacao = FormaPagamentoUm.new(calcula_valor)
    elsif tipo_pedido_debito?
      @operacao = FormaPagamentoDois.new(calcula_valor)
    end
    if @operacao.processar
      true
    else
      false
    end
  end

  def atualizar_pedido
    itens.each do |item|
      item.subtrai_do_estoque
      pedido.produtos << item
    end
    pedido.numero_pagamento = @operacao.numero
    pedido.valor_pago = @operacao.valor
    pedido.save
  end

  private


  def tipo_pedido_credito?
    pedido.tipo_pagamento_id.presence == 0
  end

  def tipo_pedido_debito?
    pedido.tipo_pagamento_id.presence == 1
  end

  def calcula_valor
    pedido.total_pedido(itens)
  end
end