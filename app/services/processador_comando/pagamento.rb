class ProcessadorComando::Pagamento

  attr_reader :numero, :valor

  def initialize(valor)
    @valor = valor
    @numero = '123456789'
  end

  def processar
    #implementado pelas sub-classes
  end

end