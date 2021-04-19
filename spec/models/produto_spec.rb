require 'rails_helper'

RSpec.describe Produto, type: :model do
    let(:produto) { Produto.new }
    subject { produto }

    describe 'validations' do
      it { is_expected.to validate_presence_of(:nome) }
      it { is_expected.to validate_presence_of(:preco) }
      it { is_expected.to validate_presence_of(:descricao) }
    end
end
