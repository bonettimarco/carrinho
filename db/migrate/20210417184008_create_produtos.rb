class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.decimal :preco, precision: 8, scale: 2
      t.text :descricao

      t.timestamps
    end
  end
end
