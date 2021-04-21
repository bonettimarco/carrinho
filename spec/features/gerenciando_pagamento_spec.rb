# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Gerenciando Pagamentos', type: :feature do
  let(:produtos) { create_list :produto, 10 }

  describe 'Pagar a crédito', js: true do
    before(:each) do
      produtos
    end
    describe 'Sucesso' do
      scenario 'Colocar produto, pagar' do
        visit root_path

        find_all('tr')[3].find_all('td')[3].click
        sleep 3

        find("input[type=submit][value='Pagar a débito']").click
        sleep 2

        expect(page).to have_content('Compra realizada com sucesso')
        expect(Pedido.count).to eq(1)
        expect(Pedido.first.produtos.count).to eq(1)
      end

      scenario 'Colocar produto, pagar' do
        visit root_path

        find_all('tr')[3].find_all('td')[3].click
        sleep 3

        find("input[type=submit][value='Pagar a crédito']").click
        sleep 2

        expect(page).to have_content('Compra realizada com sucesso')
        expect(Pedido.count).to eq(1)
        expect(Pedido.first.produtos.count).to eq(1)
      end
    end
    describe 'Com erro' do
      scenario 'Colocar produto, pagar' do
        allow_any_instance_of(ProcessadorPedido).to receive(:processar).and_return(false)
        allow_any_instance_of(ProcessadorComando).to receive(:atualizar_pedido).and_return(false)

        visit root_path

        find_all('tr')[3].find_all('td')[3].click
        sleep 4

        find("input[type=submit][value='Pagar a débito']").click
        sleep 2

        expect(page).not_to have_content('Compra realizada com sucesso')
        expect(Pedido.count).to eq(0)
      end
    end
  end
end
