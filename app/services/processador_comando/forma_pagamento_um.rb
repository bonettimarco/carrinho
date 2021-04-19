class ProcessadorComando::FormaPagamentoUm

  attr_reader :numero, :valor

  def initialize(valor)
    @valor = valor
    @numero = '678943213'
  end

  def processar
    return true
  end

  end

