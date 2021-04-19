class CreatePedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :pedidos do |t|
      t.decimal :valor_pago
      t.integer :numero_pagamento
      t.integer :tipo_pagamento_id

      t.timestamps
    end
  end
end
