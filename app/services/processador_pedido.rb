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
      self.adiciona_errors(transacao.pedido.errors) if transacao.pedido.errors.any?
      raise ActiveRecord::Rollback if transacao.pedido.errors.any?
      self
    end
  end

  def adiciona_errors(erros)
    erros.each{ |msg| errors.add(:base, msg) }
  end
end
