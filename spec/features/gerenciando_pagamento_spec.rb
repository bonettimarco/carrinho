# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Gerenciando Pagamentos', type: :feature do
  let(:produtos) { create_list :produto, 10 }

  describe 'Pagar a crédito', js: true do
    before(:each) do
      produtos
    end

    scenario 'Colocar produto, pagar' do
      visit root_path

      find_all('tr')[3].find_all('td')[3].click
      sleep 2

      find("input[type=submit][value='Pagar a débito']").click
      sleep 2

      expect(page).to have_content('Compra realizada com sucesso')
      expect(Pedido.count).to eq(1)
      expect(Pedido.first.produtos.count).to eq(1)
    end
  end
end
