# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Gerenciando Pedidos', type: :feature do
  let(:produtos) { create_list :produto, 10 }

  describe 'Manipular carrinho', js: true do
    before(:each) do
      produtos
    end

    scenario 'Visualizar produtos' do
      visit root_path

      expect(page).to have_content(produtos.first.nome)
      expect(page).to have_content(produtos.second.nome)
      expect(page).to have_content(produtos.third.nome)
      expect(page).to have_content(produtos.fourth.nome)
      expect(page).to have_content(produtos.fifth.nome)
    end

    scenario 'Colocar produtos no carrinho' do
      visit root_path
      sleep 1

      find_all('tr')[3].find_all('td')[3].click
      sleep 2

      expect(page).not_to have_content(produtos.first.nome)
      expect(page).not_to have_content(produtos.second.nome)
      expect(page).to have_content(produtos.third.nome)
      expect(page).not_to have_content(produtos.fourth.nome)
      expect(page).not_to have_content(produtos.fifth.nome)

    end

    scenario 'Colocar produto e voltar para home' do
      visit root_path

      find_all('tr')[3].find_all('td')[3].click
      sleep 2

      click_on 'Continuar comprando'
      sleep 1

      expect(page).to have_content(produtos.first.nome)
      expect(page).to have_content(produtos.second.nome)
      expect(page).to have_content(produtos.third.nome)
      expect(page).to have_content(produtos.fourth.nome)
      expect(page).to have_content(produtos.fifth.nome)
      expect(page).to have_button('Retirar do carrinho')

    end

    scenario 'Colocar produto, retirar produto' do
      visit root_path

      find_all('tr')[3].find_all('td')[3].click
      sleep 3

      click_on 'Retirar do carrinho'
      sleep 1

      expect(page).to have_content(produtos.first.nome)
      expect(page).to have_content(produtos.second.nome)
      expect(page).to have_content(produtos.third.nome)
      expect(page).to have_content(produtos.fourth.nome)
      expect(page).to have_content(produtos.fifth.nome)
      expect(page).not_to have_button('Retirar do carrinho')

    end

    scenario 'Colocar produto, voltar para home, retirar produto' do
      visit root_path

      find_all('tr')[3].find_all('td')[3].click
      sleep 3

      click_on 'Continuar comprando'
      sleep 1

      click_on 'Retirar do carrinho'
      sleep 1

      expect(page).to have_content(produtos.first.nome)
      expect(page).to have_content(produtos.second.nome)
      expect(page).to have_content(produtos.third.nome)
      expect(page).to have_content(produtos.fourth.nome)
      expect(page).to have_content(produtos.fifth.nome)
      expect(page).not_to have_button('Retirar do carrinho')

    end


  end
end
