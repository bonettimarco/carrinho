# frozen_string_literal: true

class ProcessadorPedido
  attr_reader :ids, :itens, :pedido

  def initialize(pedido, cesta)
    @pedido = pedido
    @ids = cesta
    carrega_carrinho
  end

  def carrega_carrinho
    @itens = Produto.where(id: ids)
  end

  def processar
    return false unless itens.present? && pedido.aguardando_processamento?
    ActiveRecord::Base.transaction do
      transacao = ProcessadorComando.new(pedido, itens)
      transacao.processar
      transacao.atualizar_pedido
      raise ActiveRecord::Rollback if transacao.pedido.errors.any?
      self
    end
  end
end
