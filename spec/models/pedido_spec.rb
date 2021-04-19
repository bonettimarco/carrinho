require 'rails_helper'

RSpec.describe Pedido, type: :model do

  let(:pedido) { Pedido.new }
  let(:produtos) { create_list(:produto, 10)}
  subject { pedido }

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:produtos) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:valor_pago) }
    it { is_expected.to validate_presence_of(:numero_pagamento) }
    it { is_expected.to validate_presence_of(:tipo_pagamento_id) }
  end

  describe 'métodos' do
    before(:each) do
      produtos
    end
    it '.total_pedido' do
      carrinho = Produto.ids.first(5)
      expect(subject.total_pedido(carrinho)).to eq(15)
    end

    it '.aguardando_processamento?' do
      expect(subject.aguardando_processamento?).to be_truthy
    end
  end
end
