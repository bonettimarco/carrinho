class Pedido < ApplicationRecord

  has_many :produtos

  def total_pedido(carrinho)
    item = Produto.select(:preco).where(id: carrinho)
    return item.sum(:preco)
  end

  def aguardando_processamento?
    numero_pagamento.nil?
  end
end
