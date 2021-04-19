class ProdutosController < ApplicationController
  before_action :initialize_session
  before_action :carrega_preco_total

  def index
    @produtos = Produto.all
  end

  def por_no_carrinho
    session[:carrinho] << params[:id].to_i unless ja_colocou?
    redirect_to carrinhos_path
  end

  def remover_do_carrinho
    session[:carrinho].delete(params[:id].to_i)
    redirect_to root_path
  end

  def retirar_do_carrinho

  end

  private

  def initialize_session
    session[:carrinho] ||= []
  end

  def ja_colocou?
    session[:carrinho].include?(params[:id])
  end

  def carrega_preco_total
    @carrinho = session[:carrinho]
    item = Produto.select(:preco).where(id: session[:carrinho])
    @soma = item.sum(:preco)
  end
end
