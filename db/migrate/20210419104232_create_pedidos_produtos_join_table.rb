class CreatePedidosProdutosJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :pedidos, :produtos
  end
end
