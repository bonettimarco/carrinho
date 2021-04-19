class Pedido < ApplicationRecord

  has_and_belongs_to_many :produtos

  validates :valor_pago, :numero_pagamento, :tipo_pagamento_id, presence: true
  validates :produtos, presence: true

  def total_pedido(carrinho)
    item = Produto.select(:preco).where(id: carrinho)
    return item.sum(:preco)
  end

  def aguardando_processamento?
    numero_pagamento.nil?
  end
end
