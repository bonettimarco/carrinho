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



      find_all('tr')[1].find_all('td')[2].click
      debugger

    end

    scenario 'Colocar produtos no carrinho' do
      visit root_path

      debugger

      click_link 'Confirmar dados do Aluno'
      sleep 1

      fill_autocomplete_select2 'por_nome_ou_matricula_ou_cpf', with: 'Joao Enzo'
      sleep 1

      within('.modal') do
        expect(page.body).to have_field('Nome')
        expect(page.body).to include('Joao Enzo')
        expect(page.body).to have_field('CPF')
        expect(page.body).to include('12345678901')
        expect(page.body).to have_field('Matricula')
        expect(page.body).to include('654321')
      end
    end
  end
end