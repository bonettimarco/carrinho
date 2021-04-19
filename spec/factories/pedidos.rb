FactoryBot.define do
  factory :pedido do
    valor_pago { "9.99" }
    produto { nil }
    numero_pagamento { 1 }
  end
end
