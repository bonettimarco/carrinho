# frozen_string_literal: true
require 'faker'

Produto.destroy_all

30.times do
  p = Produto.create(nome: Faker::Commerce.unique.product_name,
                     preco: rand(5000..100_000).to_d,
    descricao: Faker::Hipster.sentence(rand(3..6)))
  puts "Criando #{p.nome}"
end