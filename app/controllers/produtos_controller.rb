class ProdutosController < ApplicationController
  def index
    @produtos = Produto.all
    session[:carrinho] ||= 0
    session[:carrinho] += 1
    @carrinho = session[:carrinho]
  end
end
