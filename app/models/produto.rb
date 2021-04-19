class Produto < ApplicationRecord

  validates :nome, :preco, :descricao, presence: true

  def subtrai_do_estoque
  #  implementar
  end
end
