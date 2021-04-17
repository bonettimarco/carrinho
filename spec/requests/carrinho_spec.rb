require 'rails_helper'

RSpec.describe "Carrinhos", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/carrinho/show"
      expect(response).to have_http_status(:success)
    end
  end

end
