FactoryBot.define do
  factory :produto do
    nome { Faker::Book.title }
    preco { 3.00 }
    descricao { Faker::TvShows::Suits.quote }
  end
end
