class ProcessadorComando::FormaPagamentoDois

  attr_reader :numero, :valor

  def initialize(valor)
    @valor = valor
    @numero = '123456789'
  end

  def processar
    return true
  end

end