# frozen_string_literal: true
require 'faker'

Produto.destroy_all

30.times do
  p = Produto.create(nome: Faker::Book.title,
                     preco: rand(50..1_000).to_d,
    descricao: Faker::TvShows::Suits.quote)
  puts "Criando #{p.nome}"
end